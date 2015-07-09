
var Board = React.createClass({
  propTypes: {
    getUrl: React.PropTypes.string,
    board: React.PropTypes.array,
  },

  getInitialState: function() {
    return {board: this.props.board}
  },

  componentDidMount: function() {
    this.timer = setInterval(this.updateBoard, 1000);
  },

  updateBoard: function() {
    $.get(this.props.getUrl, function(result) {
      var game = result;
      if (this.isMounted()) {
        this.setState({
          board: game.board
        });
      }
    }.bind(this));
  },

  render: function () {
    pieces = [];

    for (var r = 0; r < this.state.board.length; r++) {
      for (var c = 0; c < this.state.board.length; c++) {
        pieces.push(<Piece owner={this.state.board[c][r]} row={r} col={c} getUrl={this.props.getUrl}/>);
      }
      pieces.push(<br />);
    }

    return (
      <div>
        { pieces }
      </div>
    );
  }
});
