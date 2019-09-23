import { Component, OnInit } from '@angular/core';
import { FullComponent } from '../layouts/full/full.component';
import { BlankComponent } from '../layouts/blank/blank.component';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from './../../environments/environment';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: [
    './home.component.css',
    '../app.component.css'
  ]
})
export class HomeComponent implements OnInit {
  marketPlace: string;
  taxCredit: string;
  constructor(private httpClient: HttpClient,) { }

  ngOnInit() {
    this.getInitialInfo();
  }

  getInitialInfo() {
    this.httpClient.get<any>(environment.apiUrl+"/hra_results/plan_details").subscribe(
      (res) => {
        console.log(res)
        this.marketPlace = res.market_place;
        this.taxCredit = res.tax_credit;
      },
      (err) => {
        console.log(err)
      }
    );
  }

}