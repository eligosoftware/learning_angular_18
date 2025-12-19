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
  searchBus(from: number, to: number, travelDate: string): Observable<any[]> {
    return this.http.get<any[]>(`/api/BusBooking/searchBus?from=${from}&to=${to}&travelDate=${travelDate}`);
  }
}
