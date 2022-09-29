import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditSquadDialogComponent } from './edit-squad-dialog.component';

describe('EditSquadDialogComponent', () => {
  let component: EditSquadDialogComponent;
  let fixture: ComponentFixture<EditSquadDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditSquadDialogComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditSquadDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
