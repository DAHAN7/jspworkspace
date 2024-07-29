/**
 * 
 */
function drop() {
     var target = event.target;
     var inputInfoDiv = target.nextElementSibling;
            
            if (inputInfoDiv.style.display === "none" || inputInfoDiv.style.display === "") {
                inputInfoDiv.style.display = "block";
            } else {
                inputInfoDiv.style.display = "none";
            }
}