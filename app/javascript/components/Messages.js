import React from "react"
import PropTypes from "prop-types"
import Message from "./Message";

class Messages extends React.Component {
    render() {
        return (
            <div className="message_area" id="message_area">
                {
                    this.props.messages.map((message, index) => {
                        return <Message key={index} message={message} dialogue_id={this.props.dialogue_id}
                                        user_id={this.props.user_id}/>
                    })
                }
            </div>
        );
    }

    scrollMessages() {
        let block = document.getElementById("message_area");
        block.scrollTop = 9999;
    }
}

export default Messages
