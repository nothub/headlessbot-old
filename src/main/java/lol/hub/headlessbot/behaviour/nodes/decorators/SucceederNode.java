package lol.hub.headlessbot.behaviour.nodes.decorators;

import lol.hub.headlessbot.behaviour.State;
import lol.hub.headlessbot.behaviour.nodes.Node;

public class SucceederNode extends DecoratorNode {
    public SucceederNode(Node parent, Node child) {
        super(parent, child);
    }

    @Override
    public State run() {
        // TODO
        return null;
    }
}
