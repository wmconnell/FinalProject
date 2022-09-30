import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TheOneComponent } from './the-one.component';

describe('TheOneComponent', () => {
  let component: TheOneComponent;
  let fixture: ComponentFixture<TheOneComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TheOneComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TheOneComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
