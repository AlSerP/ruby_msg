import React from "react"
import PropTypes from "prop-types"
import Messages from "./Messages";
import MessageForm from "./MessageForm";

class MessageApp extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            messages: props.messages,
            opponent: props.opponent
        }

        this.handleSendMessage = this.handleSendMessage.bind(this);
        this.handleUpdateMessages = this.handleUpdateMessages.bind(this);
        setInterval(this.handleUpdateMessages, 5000)
    }

    render() {
        let scroll = this.scrollMessages;
        return (
            <div className="messages">
                <h3 className="dialogue_header">{this.props.opponent}</h3>
                <Messages messages={this.state.messages} dialogue_id={this.props.dialogue_id}
                          csrf_token={this.props.csrf_token} user_id={this.props.user_id}/>
                <MessageForm csrf_token={this.props.csrf_token} onSubmit={this.handleSendMessage}/>
            </div>
        );
    }

    handleSendMessage(message) {
        let messages = this.state.messages;

        $.ajax({
            url: "/dialogue/" + this.props.dialogue_id + "/send",
            dataType: 'json',
            type: 'POST',
            data: message,
            success: function (data) {
                let updatedMessages = messages.concat([data.message]);
                this.setState({messages: updatedMessages});
                this.scrollMessages();
            }.bind(this)
        });
    }

    handleUpdateMessages() {
        let messages = this.state.messages;
        let max_id = 0
        for (let i = 1; i < messages.length; i++)
            if (Number(messages[max_id].id) < Number(messages[i].id))
                max_id = i;
        let last_message = messages[max_id];

        $.ajax({
            url: "/dialogue/" + this.props.dialogue_id + "/update",
            dataType: 'json',
            type: 'GET',
            data: {
                last_message: last_message
            },
            success: function (data) {
                if (data.messages.length > 0) {
                    let updatedMessages = messages
                    for (let i = 0; i < data.messages.length; i++)
                        updatedMessages = updatedMessages.concat([data.messages[i]]);
                    this.setState({messages: updatedMessages});
                    this.scrollMessages();
                }
            }.bind(this)
        });
    }

    scrollMessages() {
        let block = document.getElementById("message_area");
        block.scrollTop = 9999;
    }
}

export default MessageApp
