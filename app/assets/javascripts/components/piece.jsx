var Piece = React.createClass({
  propTypes: {
    owner: React.PropTypes.number,
    row: React.PropTypes.number,
    col: React.PropTypes.number,
    getUrl: React.PropTypes.string
  },

  showModal: function() {
    if (this.props.owner === 0) {
      $(React.findDOMNode(this.refs.submitModal)).fadeToggle();
    }
  },

  hideModal: function() {
    $(React.findDOMNode(this.refs.submitModal)).hide();
  },

  makeMove: function() {
    this.updateQuad;
    this.updateDirection;
    this.updateToken;

    var data = {"token":$(React.findDOMNode(this.refs.token)).val(), "row":this.props.row, "col":this.props.col, "quad":$(React.findDOMNode(this.refs.quad)).val()};
    var thiss = this;


    if ($(React.findDOMNode(this.refs.direction)).val() === "clockwise") {
      data["clockwise"] = "true";
    }

    console.log(data);

    var request = $.ajax({
      url        : this.props.getUrl + "/move",
      dataType   : 'json',
      contentType: 'application/json; charset=UTF-8',
      data       : JSON.stringify(data),
      type       : 'POST',
      error: function(data, textStatus, xhr) {
        React.findDOMNode(thiss.refs.responseStatus).innerHTML = "Response: " + xhr;
        console.log(textStatus);
      },
      success: function() {
        thiss.showModal();
      }
    });
  },

  render: function () {
    var ownerName = "piece ";

    if (this.props.owner === 1) {
      ownerName += "one";
    } else if (this.props.owner === 2) {
      ownerName += "two";
    }
    return (
      <div style={{display: 'inline'}}>
        <div className="submit-modal" ref="submitModal">
          <div className="close" onMouseDown={this.hideModal}>
            x
          </div>

          <div className="body">
            <div className="form-group">
              <label className="control-label" for="token">Player Token</label>
              <input type="text" className="form-control" id="token" ref="token" value={localStorage.getItem('playerToken')}/>
            </div>

            <div className="form-group">
              <label for="quad">Quadrant to Rotate</label>
              <select className="form-control" id="quad" ref="quad" >
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>
            </div>

            <div className="form-group">
              <label for="direction">Quadrant to Rotate</label>
              <select className="form-control" id="direction" ref="direction" >
                <option>clockwise</option>
                <option>cournter-clockwise</option>
              </select>
            </div>

            <div className="form-group">
              <p ref="responseStatus">
                Response: (make move to see response)
              </p>
            </div>

            <button type="button" className="btn make-move btn-primary" onMouseDown={this.makeMove}>Make Move</button>
          </div>
        </div>

        <div className={ownerName} type="button" onMouseDown={this.showModal}>
          <div className="piece-label">
            {this.props.row}, {this.props.col}
          </div>
        </div>
      </div>
    );

  }
});
