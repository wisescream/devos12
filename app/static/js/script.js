document.addEventListener('DOMContentLoaded', function() {
    const fetchBtn = document.getElementById('fetchData');
    const dataContainer = document.getElementById('apiDataContainer');
    
    fetchBtn.addEventListener('click', function() {
        fetch('/api/data')
            .then(response => response.json())
            .then(data => {
                dataContainer.innerHTML = `
                    <h4>API Response:</h4>
                    <pre>${JSON.stringify(data, null, 2)}</pre>
                `;
            })
            .catch(error => {
                dataContainer.innerHTML = `<p class="error">Error fetching data: ${error}</p>`;
            });
    });
});