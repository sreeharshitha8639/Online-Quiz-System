window.onload = function () {
    let duration = 10 * 60; // 5 minutes in seconds
    const display = document.getElementById("timer");

    const timerInterval = setInterval(function () {
        let minutes = Math.floor(duration / 60);
        let seconds = duration % 60;

        // Format MM:SS
        display.textContent = 
            (minutes < 10 ? "0" + minutes : minutes) + ":" + 
            (seconds < 10 ? "0" + seconds : seconds);

        // When timer reaches zero
        if (--duration < 0) {
            clearInterval(timerInterval);
            alert("⏰ Time's up! Submitting your quiz.");
            document.getElementById("quizForm").submit();
        }
    }, 1000); // every second
};
