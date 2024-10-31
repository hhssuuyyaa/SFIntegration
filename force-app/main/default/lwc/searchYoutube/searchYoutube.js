import { LightningElement } from 'lwc';
import getSearchDetails from '@salesforce/apex/SearchYoutubeController.getSearchDetails';

export default class SearchYoutube extends LightningElement {

    searchText = ''
    searchResult

    handleClick(event){
        console.log('searchText'+this.searchText);
        getSearchDetails({searchText: this.searchText})
            .then(result => {
                this.searchResult = result;
            })
    }

    handleTextChange(event){
        this.searchText = event.target.value;
    }

    handleClear(event){
        this.searchText = '';
        this.searchResult = '';
    }
}