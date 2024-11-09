package lol.hub.headlessbot.mixins;

import lol.hub.headlessbot.MC;
import lol.hub.headlessbot.Metrics;
import lol.hub.headlessbot.Mod;
import net.minecraft.network.ClientConnection;
import net.minecraft.network.listener.PacketListener;
import net.minecraft.network.packet.Packet;
import net.minecraft.network.packet.s2c.common.KeepAliveS2CPacket;
import net.minecraft.network.packet.s2c.play.DeathMessageS2CPacket;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(ClientConnection.class)
public abstract class ClientConnectionMixin {

    // incoming packets
    @Inject(method = "handlePacket", at = @At("HEAD"), cancellable = true)
    private static <T extends PacketListener> void onHandlePacket(Packet<T> packet, PacketListener listener, CallbackInfo ci) {
        if (packet instanceof KeepAliveS2CPacket p) {
            Mod.lastKeepAlive = System.currentTimeMillis();
        }

        if (packet instanceof DeathMessageS2CPacket p) {
            if (MC.inGame() && MC.player().getId() == p.playerId()) {
                Metrics.deaths.inc();
            }
        }
    }

    // outgoing packets
    @Inject(method = "send(Lnet/minecraft/network/packet/Packet;)V", at =
    @At("HEAD"), cancellable = true)
    private void onSendPacketHead(Packet<?> packet, CallbackInfo ci) {

    }

}
