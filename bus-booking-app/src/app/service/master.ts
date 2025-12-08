import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class Master {
  private http = inject(HttpClient);

  getLocations(): Observable<any> {
    // Use proxy path instead of full URL
    return this.http.get('/api/BusBooking/GetBusLocations');
  }
}
