import { ChangeDetectionStrategy, Component, inject, Inject, OnInit } from '@angular/core';
import { Master } from '../../service/master';
import { Observable } from 'rxjs';
import { AsyncPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-search',
  imports: [AsyncPipe, FormsModule],
  templateUrl: './search.html',
  styleUrl: './search.css',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class Search implements OnInit {



  locations : Observable<any[]> = new Observable<any[]>();

  masterSrv = inject(Master);

  busList: any[] = [];

  searchObject: any = {
    from: '',
    to: '',
    travelDate: ''
  };
  ngOnInit(): void {
    this.getLocations();
  }

  getLocations() {

    this.locations = this.masterSrv.getLocations();
}

onSearch() {
  const {from, to, travelDate} = this.searchObject;
this.masterSrv.searchBus(from, to, travelDate).subscribe((res:any) => {
  this.busList = res;
});
}

}
