import React from "react"
import PropTypes from "prop-types"

class MessageForm extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            text: '',
        }

        this.handleBodyChange = this.handleBodyChange.bind(this)
        this.handleSubmit = this.handleSubmit.bind(this)
    }

    handleBodyChange(e) {
        const updatedValue = e.target.value
        this.setState(prevState => {
            return {
                text: updatedValue
            };
        });
    }

    handleSubmit(e) {
        e.preventDefault();
        let text = this.state.text.trim();
        if (!text) {
            return;
        }

        this.state.text = '';
        this.props.onSubmit({text: text});
    }

    render() {
        return (
            <div className="send_card">
                <div className="send_body">
                    <form onSubmit={this.handleSubmit}>
                        <div className="message_input_box">
                            <input type="text"
                                   name="text"
                                   id="message_text"
                                   className="message_input"
                                   autoComplete="off"
                                   spellCheck="true"
                                   placeholder="Text your message ..."
                                   value={this.state.text}
                                   onChange={this.handleBodyChange}
                                   autoFocus/>
                        </div>
                        <input type="hidden" value={this.props.csrf_token}/>
                        <button type="submit" className="send_button">Send</button>
                    </form>
                </div>
            </div>
        );
    }
}

export default MessageForm
