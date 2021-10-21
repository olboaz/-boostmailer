const importCsv = () => {

  const csvInput = document.querySelector('.supplier-csv input');
  const filenameForm = document.querySelector('.filename-csv');
  const titleForm = document.querySelector('.supplier-csv .title-csv');
  const buttonForm = document.querySelector('.btn-csv');
  const buttonClose = document.querySelector('.close');

  if (csvInput){
    csvInput.addEventListener('change', (event) => {
      event.preventDefault();
      if (! /^.+(\.csv)$/i.test(csvInput.value)) {
        alert("Le fichier sélectionné n'est pas au format .csv");
      }else{
      if(csvInput.files.length == 1){
        $(".filename-csv").fadeOut(1);
        $(".btn-csv").fadeOut(1);
      }

      if(csvInput.files[0].name.length > 15){
        filenameForm.innerText = csvInput.files[0].name.substring(0, 15) + "..." + " ajouté !";
      } else {
        filenameForm.innerText = csvInput.files[0].name + " ajouté !";
      }

      $(".filename-csv").fadeIn(3000);
      $(".btn-csv").fadeIn(3000);
      }
    });
  }

  if(buttonClose){
    buttonClose.addEventListener('click', (event) => {
      event.preventDefault();
      if(csvInput){
        if(csvInput.files.length == 1){
          $(".filename-csv").fadeOut(1);
          $(".btn-csv").fadeOut(1);
        }
      }
    });
  }
}


export {importCsv};importCsv.js
