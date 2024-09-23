document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('text').addEventListener('click', function() {
        alert('Элемент был нажат!');
        this.style.backgroundColor = 'yellow';
        setTimeout(function() {
            this.style.color = 'red';
        }, 1000);
    });
});