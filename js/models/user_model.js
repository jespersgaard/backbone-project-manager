var project_mgr = project_mgr || {};

project_mgr.User = Backbone.Model.extend({

    urlRoot: "api/index.php/login",
    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        return base + "/" + encodeURIComponent(this.get('username')) + "/" + encodeURIComponent(this.get('password'));

    },
            
    defaults: {
    username: 'guest',
    password: 'guestpw'
    }
    
});
