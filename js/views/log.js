var project_mgr = project_mgr || {};

$(function() {
	'use strict';
        //Individual logs that can be edited in place
        project_mgr.ProjectLogItemView = Backbone.View.extend({

//            el: "ul",
            
//            tagname: "#tabs-log",
            
            template: _.template( $('#log-template').html() ),
            
            editTemplate: _.template( $('#log-edit-template').html() ),

		// The DOM events specific to an item.
		events: {
			'click li':             'editLog',
                        'blur .edit_entry':     'saveLog' 
//			'click .destroy':	'clear',
//			'keypress .edit':	'updateOnEnter',
//			'blur .edit':		'close'
		},
                
            initialize: function () {
                //When a change is made to the entry in editTemplate, its blur
                //method will change this model's entry_text and re-render the 
                //display view for this log entry
                this.model.bind("change", this.render, this);
//                this.model.bind("destroy", this.close, this);
            },
            render: function () {
                $(this.el).html(this.template(this.model.toJSON()));
                return this;
            },
            // Switch this view into `"editing"` mode, displaying the text area.
            editLog: function() {
                console.log('about to edit log entry: ' + this.model.get('id'));
                $(this.el).html(this.editTemplate(this.model.toJSON()));
                $(this.el).find('.edit_entry').focus();
            },
            saveLog: function(){
                var entry = $(this.el).find('.edit_entry').val().trim();
                console.log('about to save log entry: ' + entry);
                //maybe automate this instead by binding any changes to the view
                //to the model's logEdited method.*UPDATE: which I did, however
                //if the entry text remains untouched then there is no change
                //to model in save, because the model must be smart enough to
                //know that a save is being called on the exact same text.
                this.render();
                this.model.save({ entry_text: entry },{success: function(){
                        console.log('log updates/saved successfully');
                }});
            }                  

        });      
        
       
        project_mgr.ProjectLogsView = Backbone.View.extend({

//		el: '#tabs-log',
                        
		template: _.template( $('#log-group-template').html() ),

		//Listen for the following actions on the model and then perform
                //the appropriate action
                initialize: function() {
//			this.listenTo(this.model, 'change', this.render);
//			this.listenTo(this.model, 'destroy', this.remove);
                        $(this.el).attr('id', '#log-page');
                        $('#tabs-log').append($(this.el));
                        
                        this.render();
		},

		render: function() {
                    var logs = this.model.models;
                    var len = logs.length;
                    for(var i = 0; i < len; i++){            
                        //If this log entry doesn't already have a parent ul with
                        //an id associated with its date then create one.
                        var logItemView = new project_mgr.ProjectLogItemView({model: logs[i]});
                        this.addNewChildView(logItemView);
                    }
		},
                addNewChildView: function(logItemView){
                    if(($("#" + logItemView.model.get('date')).length === 0 )) {            
                        $(this.el).prepend(this.template(logItemView.model.toJSON()));
                    }

                    $('#' + logItemView.model.get('date')).prepend(logItemView.render().el);
                }
	});
        
});

