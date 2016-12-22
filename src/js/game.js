
class Game {
    constructor() {
        console.log('[Game] create instance');

        var config = {width: 640, height: 960, policy: 'FIXED_WIDTH'};
        var director = new Director(config);
        director.start();
        this.director = director;

        this.countLabel = document.createElement('div');
        this.countLabel.innerHTML = '0 stars';
        this.countLabel.style.cssText = 'position:absolute;top:2px;left:90px;z-index:10000;font:bold 24px Helvetica,Arial,sans-serif;color:red;';
        document.body.appendChild(this.countLabel);

        var self = this;
        var view = this.director.getRenderer().view;
        view.style.cssText = 'cursor: pointer;';
        view.addEventListener('touchstart', function(event) {
            self.addStars(100);
        }, false );
        view.addEventListener('click', function(event) {
            self.addStars(100);
        }, false );
    }

    start() {
        console.log('[Game] start');

        this.radians = Math.PI / 180;

        this.starTexture = PIXI.Texture.fromImage('res/star.png');
        this.scene = new PIXI.Container();
        var self = this;
        this.scene.update = function(dt) {
            self.update(dt);
        }

        this.director.runWithScene(this.scene);

        this.starsLayer = new PIXI.Container();
        this.scene.addChild(this.starsLayer);
        this.stars = [];
        self.addStars(100);
    }

    addStars(count) {
        var size = this.director.size;
        for (var i = 0; i < count; i++) {
            var star = new PIXI.Sprite(this.starTexture);
            star.position.set(Math.random() * size.width, Math.random() * size.height);
            star.anchor.set(0.5, 0.5);
            this.starsLayer.addChild(star);
            this.stars.push(star);
        }

        this.countLabel.innerHTML = this.stars.length.toString() + ' stars';
    }

    update(dt) {
        var count = this.stars.length;

        for (var i = 0; i < count; i++) {
            this.stars[i].rotation += this.radians;
        }
    }
}

