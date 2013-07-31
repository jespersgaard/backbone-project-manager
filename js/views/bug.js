var project_mgr = project_mgr || {};

$(function() {
	'use strict';
                
        //Individual logs that can be edited in place
        project_mgr.ProjectBugItemView = Backbone.View.extend({
            
            template: _.template( $('#bug-template').html() ),
            
            bugEditTemplate: _.template( $('#bug-edit-template').html() ),
            
            noteEditTemplate: _.template( $('#note-edit-template').html() ),

            events: {
                    'click .editable#bug':              'editBug',
                    'click .editable#note':             'editNote',
                    'click .editable_toggle':           'editStatus',
                    'mouseover .editable_toggle':       'displayButton',
                    'mouseout .editable_toggle':        'hideButton',
                    'blur .edit_entry#bug':             'saveBug', 
                    'blur .edit_entry#note':            'saveNote' 
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
            editBug: function() {
                $(this.el).html(this.bugEditTemplate(this.model.toJSON()));
                $(this.el).find('.edit_entry').focus();
            },
            editNote: function(){
                $(this.el).html(this.noteEditTemplate(this.model.toJSON()));
//                $(this.el).find('textarea').attr('id', 'note');
                $(this.el).find('.edit_entry').focus();
            },            
            editStatus: function(){
                if(this.model.get('open') == '1'){
                    this.model.save({ open: '0'});
                }else{
                    this.model.save({ open: '1'});
                }
                this.render();
            },
            displayButton: function(){
                var button = $(this.el).find('.toggle_button');
                button.width(45);
                $(this.el).find('.text').empty();
                if(this.model.get('open') == '1'){
                    button.attr('value', 'Close');
                }else{
                    button.attr('value', 'Open');
                }
                button.show();
            },
            hideButton: function(){
                $(this.el).find('.toggle_button').hide();
                if(this.model.get('open') == '1'){
                    $(this.el).find('.text').html('Open');
                }else{
                    $(this.el).find('.text').html('Closed');
                }
            },
            saveBug: function(){
                var entry = $(this.el).find('.edit_entry').val().trim();
                
                //maybe automate this instead by binding any changes to the view
                //to the model's logEdited method.*UPDATE: which I did, however
                //if the entry text remains untouched then there is no change
                //to model in save, because the model must be smart enough to
                //know that a save is being called on the exact same text.
                this.render();
                this.model.save({ entry: entry});
            },
            saveNote: function(){
                var notes = $(this.el).find('.edit_entry').val().trim();
                this.render();
                this.model.save({ notes: notes});        
            }

        });      
        
       
        project_mgr.ProjectBugsView = Backbone.View.extend({

		template: _.template( $('#bug-group-template').html() ),

		//Listen for the following actions on the model and then perform
                //the appropriate action
                initialize: function() {
//			this.listenTo(this.model, 'change', this.render);
//			this.listenTo(this.model, 'destroy', this.remove);

                        $(this.el).attr('id', '#bug-page');
                        $(this.el).append(this.template());
                        $('#tabs-bugs').append($(this.el));
                        
                        this.render();
		},

		render: function() {
                    var bugs = this.model.models;
                    var len = bugs.length;
                    for(var i = 0; i < len; i++){
                        var bugItemView = new project_mgr.ProjectBugItemView({model: bugs[i]});
                        this.addNewChildView(bugItemView);
                    }
		},
                addNewChildView: function(bugItemView){
                        //if I set el: 'tr' in the bugitemview object it looks for 
                        //that element in the dom, and it does exist there as part of the
                        //header for each table, so that ends up getting wiped out.
                        var newEl = $('<tr></tr>');
                        bugItemView.setElement(newEl);
                        if(bugItemView.model.get('open') == 1 ) {
                            $("tbody#open").append(newEl);
                            $("tbody#open").prepend(bugItemView.render().el);                            
                        }else {
                            $("tbody#closed").append(newEl);
                            $("tbody#closed").prepend(bugItemView.render().el);                            
                        }
                }
	});
        
});

