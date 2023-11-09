function getCurrentDate() {
    var date = new Date();

    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    var hours = date.getHours().toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');
    var seconds = date.getSeconds().toString().padStart(2, '0');
    
    return year + "-"+month+"-"+day+" "+ hours + ":" + minutes + ":" + seconds;
}

function getCurrentFormattedDate() {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const date = new Date();

    let month = months[date.getMonth()];
    let day = date.getDate();
    let year = date.getFullYear();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    let ampm = hours >= 12 ? "PM" : "AM";

    // Convert 24-hour time to 12-hour time
    hours %= 12;
    hours = hours || 12; // Handle midnight

    const formattedDate = `${month} ${day}, ${year}, ${hours}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')} ${ampm}`;
    
    return formattedDate;
}

function convertToSQLDate(date){
    return date.getFullYear() + "-"+date.getMonth()+"-"+date.getDate()+" "+ date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
}