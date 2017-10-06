% solve a SVM problem using ForBES

close all;
clear;

rng(0, 'twister');

n = 20000; % number of features (= number of variables minus one)
m = 3000; % number of samples

w = sprandn(n, 1, 0.3);  % N(0,1), 30% sparse
v = randn(1);            % random intercept

X = sprandn(m, n, 10/n);
btrue = sign(X*w + v);

% noise is function of problem size use 0.1 for large problem
b = sign(X*w + v + sqrt(0.1)*randn(m,1)); % labels with noise

A = [X, ones(m, 1)];

ratio = sum(b == 1)/(m);
lam = 0.1 * norm((1-ratio)*sum(A(b==1,:),1) + ratio*sum(A(b==-1,:),1), 'inf');

fprintf('%d instances, %d features, nnz(A) = %d\n', size(A, 1), size(A, 2), nnz(A));

f = forbes.functions.SqrNormL2(lam);
g = forbes.functions.HingeLoss(1, b);
constr = {A, -1, zeros(m, 1)};
y0 = zeros(m, 1);
opt.maxit = 10000;
opt.tol = 1e-6;
opt.display = 1;

fprintf('\nFast FBS\n');
opt_fbs = opt;
opt_fbs.solver = 'fbs';
opt_fbs.variant = 'fast';
out_fbs = forbes(f, g, y0, [], constr, opt_fbs);
fprintf('\n');
fprintf('message    : %s\n', out_fbs.message);
fprintf('iterations : %d\n', out_fbs.solver.iterations);
fprintf('matvecs    : %d\n', out_fbs.solver.operations.C1);
fprintf('prox       : %d\n', out_fbs.solver.operations.proxg);
fprintf('time       : %7.4e\n', out_fbs.solver.ts(end));
fprintf('residual   : %7.4e\n', out_fbs.solver.residual(end));

fprintf('\nL-BFGS\n');
opt_lbfgs = opt;
opt_lbfgs.method = 'lbfgs';
out_lbfgs = forbes(f, g, y0, [], constr, opt_lbfgs);
fprintf('\n');
fprintf('message    : %s\n', out_lbfgs.message);
fprintf('iterations : %d\n', out_lbfgs.solver.iterations);
fprintf('matvecs    : %d\n', out_lbfgs.solver.operations.C1);
fprintf('prox       : %d\n', out_lbfgs.solver.operations.proxg);
fprintf('time       : %7.4e\n', out_lbfgs.solver.ts(end));
fprintf('residual   : %7.4e\n', out_lbfgs.solver.residual(end));
