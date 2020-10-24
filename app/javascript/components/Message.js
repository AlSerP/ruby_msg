import React from "react"
import PropTypes from "prop-types"

class Message extends React.Component {


    render() {
        return (
            <div className="message_line">{this.generateMessage()}{this.message}</div>
        );
    }

    generateMessage() {
        if (this.props.user_id === this.props.message.user_by)
            this.message =  <div className="message my_message"> {this.props.message.text} </div>;
        else
            this.message = <div className="message opponent_message"> {this.props.message.text} </div>;
    }
}

export default Message
