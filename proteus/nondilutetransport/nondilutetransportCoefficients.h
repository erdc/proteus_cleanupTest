extern void ConMassFluidEvaluate(const int nPoints,
                                 const int nSpace,
                                 int elements,
                                 int points,
                                 int dof_length,
                                 double *mass_frac_dof,
                                 const double K,
                                 const double grav,
                                 const double dt,
                                 const double poro,
                                 const double L,
                                 const double *u,
                                 double *m,
                                 double *dm,
                                 double *f,
                                 double *df,
                                 double *phi,
                                 double *dphi,
                                 double *a,
                                 double *da,
                                 double *r,
                                 double *x,
                                 double *mass_frac,
                                 double *mass_frac_old);

extern void NonDiluteDispersionEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double diff,
                          const double alpha_L,
                          const double R,
                          const double theta,
                          const double MW_a,
                          const double MW_b,
                          const double beta1,
                          const double beta2,
                          const double *w,
                          const double *act,
                          double *m,
                          double *dm,
                          double *f,
                          double *df,
                          double *r,
                          double *dr0,
                          double *dr1,
                          double *a00,
                          double *da000,
                          double *a01,
                          double *da010,
                          double *da011,
                          double *velocity,
                          double *pressure,
                          double *w_old,
                          const double *grad_w,
                          const double *grad_act,
                          double *phi0,
                          double *dphi00,
                          double *dphi01,
                          double *phi1,
                          double *dphi10,
                          double *dphi11,
                          double *x);

extern void NonDilutePhiDispersionEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double diff,
                          const double alpha_L,
                          const double R,
                          const double theta,
                          const double MW_a,
                          const double MW_b,
                          const double beta1,
                          const double beta2,
                          const double *w,
                          const double *act,
                          double *phi0,
                          double *dphi00,
                          double *dphi01,
                          double *phi1,
                          double *dphi10,
                          double *dphi11,
                          double *f);


extern void NonDiluteEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double diff,
                          const double alpha_L,
                          const double R,
                          const double theta,
                          const double MW_a,
                          const double MW_b,
                          const double beta1,
                          const double beta2,
                          const double *w,
                          const double *act,
                          double *m,
                          double *dm,
                          double *f,
                          double *df,
                          double *r,
                          double *dr0,
                          double *dr1,
                          double *a00,
                          double *da000,
                          double *a01,
                          double *da010,
                          double *da011,
                          double *velocity,
                          double *pressure,
                          const double *grad_w,
                          const double *grad_act,
                          double *phi0,
                          double *dphi00,
                          double *dphi01,
                          double *phi1,
                          double *dphi10,
                          double *dphi11,
                          double *x);

extern void NonDilutePhiEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double diff,
                          const double alpha_L,
                          const double R,
                          const double theta,
                          const double MW_a,
                          const double MW_b,
                          const double beta1,
                          const double beta2,
                          const double *w,
                          const double *act,
                          double *phi0,
                          double *dphi00,
                          double *dphi01,
                          double *phi1,
                          double *dphi10,
                          double *dphi11,
                          double *f);



extern void AdvectionEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double diff,
                          const double alpha_L,
                          const double *u,
                          double *m,
                          double *dm,
                          double *f,
                          double *df,
                          double *a,
                          double *da,
                          double *velocity);








extern void NonDiluteTESTEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double grav,
                          const double K,
                          const double L,
                          const double diff,
                          const double alpha_L,
                          const double R,
                          const double theta,
                          const double MW_a,
                          const double MW_b,
                          const double beta1,
                          const double beta2,
                          const double *press,
                          const double *w,
                          double *m0,
                          double *m1,
                          double *dm01,
                          double *dm11,
                          double *phi0,
                          double *phi1,
                          double *dphi00,
                          double *dphi01,
                          double *dphi10,
                          double *dphi11,
                          double *f1,
                          double *df10,
                          double *df11,
                          double *a00,
                          double *a10,
                          double *a11,
                          double *da001,
                          double *da101,
                          double *da111,
                          const double *x,
                          const double *grad_press);


extern void NonDilutePhiTESTEvaluate(const int nPoints,
                          const int nSpace,
                          const double poro,
                          const double grav,
                          const double L,
                          const double *press,
                          const double *w,
                          double *phi0,
                          double *phi1,
                          double *dphi00,
                          double *dphi01,
                          double *dphi10,
                          double *dphi11,
                          double *f,
                          const double *x);
