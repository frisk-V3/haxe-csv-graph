import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

class Main {
    static function main() {
        // CSV を読み込む
        Browser.window.fetch("sample.csv")
            .then(r -> r.text())
            .then(text -> {
                var lines = text.split("\n");
                var xs = [];
                var ys = [];

                for (i in 1...lines.length) {
                    var row = StringTools.trim(lines[i]);
                    if (row == "") continue;
                    var cols = row.split(",");
                    xs.push(Std.parseFloat(cols[0]));
                    ys.push(Std.parseFloat(cols[1]));
                }

                drawGraph(xs, ys);
            });
    }

    static function drawGraph(xs:Array<Float>, ys:Array<Float>) {
        var canvas:CanvasElement = cast Browser.document.getElementById("graph");
        var ctx:CanvasRenderingContext2D = canvas.getContext2d();

        var w = canvas.width;
        var h = canvas.height;
        var maxY = 0.0;
        for (y in ys) if (y > maxY) maxY = y;

        ctx.strokeStyle = "blue";
        ctx.lineWidth = 2;

        for (i in 0...ys.length - 1) {
            var x1 = i * (w / ys.length);
            var y1 = h - (ys[i] / maxY * h);
            var x2 = (i + 1) * (w / ys.length);
            var y2 = h - (ys[i + 1] / maxY * h);

            ctx.beginPath();
            ctx.moveTo(x1, y1);
            ctx.lineTo(x2, y2);
            ctx.stroke();
        }
    }
}
