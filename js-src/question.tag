<question>
    <h1 class="heading">{ opts.question.heading }</h1>
    <p class="description"><raw content="{ opts.question.description }"></raw></p>

    <h2 class="question-title"><raw content="{ opts.question.question }"></raw></h2>
    <ul class="choices" show="{ !opts.question.renderAsButtons }">
        <li each="{ opts.question.choices }"><input name="choice" id="choice[{to}]" class="choice" type="radio" value="{ to }" onchange="{ onChange }" /><label for="choice[{to}]">{ text }</label></li>
    </ul>

    <div show="{ opts.question.renderAsButtons }">
        <button each="{ opts.question.choices }" class="button" onclick="{ onCustomButtonClick }" data-to="{ to }" data-is-external-link="{ isExternalLink }">{ text }</button>
    </div>
    <div hide="{ opts.question.isResolution }">
        <button class="back-button is-hidden" onclick="{ parent.displayPrev }">Back</button>
        <button class="disabled next-button" disabled onclick="{ parent.displayNext }">Next</button>
    </div>
    <button class="enter-button is-hidden" onclick="{ parent.displayEnd }">Enter</button>

    <script>
    onChange() {
        if ($("input[type=radio]:checked", this.root).length > 0) {
            $(".next-button", this.root).prop("disabled", false);
            $(".next-button", this.root).removeClass("disabled");
        } else {
            $(".next-button", this.root).prop("disabled", true);
            $(".next-button", this.root).addClass("disabled");
        }
        this.update();
    }

    doUpdate() {
        if (typeof this.opts.question.canEnter !== 'undefined' && this.opts.question.canEnter) {
            $(".next-button, .back-button", this.root).addClass("is-hidden");
            $(".enter-button", this.root).removeClass("is-hidden");
        } else {
            if (this.parent.log.length > 1) {
                $(".back-button", this.root).removeClass("is-hidden");
            } else {
                $(".back-button", this.root).addClass("is-hidden");
            }
            if (opts.question.choices === null) {
                $(".next-button", this.root).addClass("is-hidden");
            } else {
                $(".next-button", this.root).removeClass("is-hidden");
            }
            this.onChange();
        }
    }

    onCustomButtonClick(e) {
        var target = $(e.target);
        if (target.data('is-external-link')) {
            window.location.href = target.data('to');
        } else {
            this.parent.displayNext(null, target.data('to'));
        }
    }
    </script>
</question>