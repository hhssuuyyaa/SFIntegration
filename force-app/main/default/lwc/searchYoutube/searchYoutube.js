import { LightningElement,track } from 'lwc';
import getSearchDetails from '@salesforce/apex/SearchYoutubeController.getSearchDetails';
export default class SearchYoutube extends LightningElement {

    searchText = ''
    @track data

    handleClick(event){
        getSearchDetails({searchText: this.searchText})
            .then(result => {
                this.data = result;
            })
    }

    handleTextChange(event){
        this.searchText = event.target.value;
    }

    handleClear(event){
        this.searchText = '';
        this.data = null;
    }

    
}