
var ClickToSelect = React.createClass({
  propTypes: {
    children: React.PropTypes.any.isRequired
  },
  select: function(e) {
    e.preventDefault();
    var self = React.findDOMNode(this),
      range = document.createRange(),
      sel = window.getSelection();
    range.selectNodeContents(self);
    sel.removeAllRanges();
    sel.addRange(range);
  },
  render: function() {
    return React.createElement(
      'span',
      { onClick: this.select },
      this.props.children);
  }
});

var GameControls = React.createClass({
  propTypes: {
    getUrl: React.PropTypes.string,
    gameId: React.PropTypes.number
  },

  getInitialState: function() {
    return {
      token: "",
      playerName: "Pentaclone Player",
      playsFirst: false
    }
  },

  joinGame: function() {
    var thiss = this;
    var data = {"name": React.findDOMNode(this.refs.playerName).value};
    console.log(data);

    var request = $.ajax({
      url        : this.props.getUrl + "/join",
      dataType   : 'json',
      contentType: 'application/json; charset=UTF-8',
      data       : JSON.stringify(data),
      type       : 'POST',
      error: function(data, textStatus, xhr) {
        $(React.findDOMNode(thiss.refs.joinFail)).fadeIn();
      },
      success: function(data, textSTatus, xhr) {

        thiss.setState({
          token: data.player_token
        });

        if (data.first_move) {
          thiss.setState({
            playsFirst: true
          });
        }

        thiss.showPlayerToken();
      }
    });
  },

  selectText:function () {
    console.log('here');
    $(React.findDOMNode(this.refs.playerTokenWell)).select();
  },

  showPlayerToken: function() {
    $(React.findDOMNode(this.refs.joinForm)).slideToggle();
    $(React.findDOMNode(this.refs.playerToken)).slideToggle();
  },

  render: function () {
    return (
      <div>
        <div ref="joinForm">

          <h3>Join Game</h3>
          <p><em>Enter a player name to join</em></p>
          <div className="form-group">
            <label className="control-label" for="name">Player Name</label>
            <input type="text" className="form-control" id="name" ref="playerName" placeholder={this.state.playerName} />
          </div>
          <button href="#" className="btn btn-default pull-right" onMouseDown={this.joinGame}>Join</button>
          <div className="alert alert-dismissible alert-danger join-failure" ref="joinFail">
            There was an error processing your request. Try again or join a new game.
          </div>
        </div>

        <div ref="playerToken" id="playerToken">
          <h3>Player Token:</h3>
          <div className="well">
            <ClickToSelect>{ this.state.token }</ClickToSelect>
          </div>
          <p>
            You make the {this.state.playsFirst ? "first" : "second"} move.
          </p>
          <p>
            Click an empty spot on the board to play (if it's your turn).
          </p>
        </div>
      </div>
    );
  }
});
