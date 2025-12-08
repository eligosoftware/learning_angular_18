import { ChangeDetectionStrategy, Component, inject, Inject, OnInit } from '@angular/core';
import { Master } from '../../service/master';
import { Observable } from 'rxjs';
import { AsyncPipe } from '@angular/common';

@Component({
  selector: 'app-search',
  imports: [AsyncPipe],
  templateUrl: './search.html',
  styleUrl: './search.css',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class Search implements OnInit {

  locations : Observable<any[]> = new Observable<any[]>();

  masterSrv = inject(Master);

  ngOnInit(): void {
    this.getLocations();
  }

  getLocations() {

    this.locations = this.masterSrv.getLocations();
}
}
