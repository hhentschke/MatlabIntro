function example_clustering_parallel
% This function demonstrates the benefits of using
% parallel computing functionality in Matlab.

% We are testing the capability of the k-means
% clustering algorithm to separate three groups of
% 3D data clouds from each other (imagine these as
% different groups of insects buzzing (or not)
% around in our real world). Two of the groups are
% stationary; the third one traverses the space in
% between, making the task of assigning
% individuals to groups/clusters harder.

% 1. Define artificial clusters of data in 3D. For
% reasons of programming convenience, make the
% first cluster mobile and keep the 2nd and 3rd
% stationary. Begin by defining their positions at
% the outset.
clu=struct();
% FIRST CLUSTER
% - number of elements
clu(1).n=1e4;
% - center
clu(1).mn=[2.5 5 0];
% - sd
clu(1).sd=[1.0 1.0 1.0];

% SECOND CLUSTER
clu(2).n=1e4;
clu(2).mn=[0 0 0];
clu(2).sd=[1.0 1.0 1.0];

% THIRD CLUSTER
clu(3).n=1e4;
clu(3).mn=[5 0 0];
clu(3).sd=[1.0 1.0 1.0];

nClu=numel(clu);

% 2. generate data and plot an overview
figure(1)
clf
hold on
% d will hold the individual data points'
% positions
d=[];
% cluIx is the cluster index, so it's 1 for the
% first cluster, and so on
cluId=[];
ph=gobjects;
for cI=1:nClu
  tmpD=randn(clu(cI).n,3);
  tmpD=tmpD.*repmat(clu(cI).sd,[clu(cI).n 1])+repmat(clu(cI).mn,[clu(cI).n 1]);
  d=cat(1,d,tmpD);
  cluId=cat(1,cluId,repmat(cI,[clu(cI).n 1]));
  % plot a subset only
  ph(cI)=plot3(tmpD(1:100,1),tmpD(1:100,2),tmpD(1:100,3),'o');
end
grid on
view(-10,50)
xlabel('x');
ylabel('y');
zlabel('z');
legend(ph)
drawnow

% 3. Preparations for clustering
% set the maximal number of iterations to find the
% best clusters to 1000
sts=statset('MaxIter',1000);
% compute clusters using nReplic different initial
% conditions
nReplic=50;
% nLoopExec loop executions, during which cluster
% 1 will move from its original position through
% the middle of the two other clusters
nLoopExec=20;
cluster1_yCenter=linspace(clu(1).mn(2),-clu(1).mn(2),nLoopExec);

% 4. shift group 1, run clustering algorithm and
% plot clustering error
figure(2)
clf
% ------------------------------
%        serial code
% ------------------------------
idxArr=nan(size(d,1),nLoopExec);
tic
for g=1:nLoopExec
  cluData=d;
  cluData(1:clu(1).n,2)=cluData(1:clu(1).n,2)+cluster1_yCenter(g)-clu(1).mn(2);
  idx=kmeans(cluData,nClu,'Replicates',nReplic,'Options',sts);
  idxArr(:,g)=idx;
end
t1=toc;
% quantify the difference between given and
% computed cluster assignment in a simple way by
% computing the proportion of wrongly assigned
% data points
err=cluEval(idxArr,d,clu);
subplot(nClu,1,1)
plot(cluster1_yCenter,err);
grid on
xlabel('y position cluster 1')
ylabel('error')
drawnow
% ------------------------------
%     parallel for loop 
% ------------------------------
idxArr=nan(size(d,1),nLoopExec);
tic
parfor g=1:nLoopExec
  cluData=d;
  cluData(1:clu(1).n,2)=cluData(1:clu(1).n,2)+cluster1_yCenter(g)-clu(1).mn(2);
  idx=kmeans(cluData,nClu,'Replicates',nReplic,'Options',sts);
  idxArr(:,g)=idx;
end
t2=toc;
err=cluEval(idxArr,d,clu);
subplot(nClu,1,2)
plot(cluster1_yCenter,err);
grid on
xlabel('y position cluster 1')
ylabel('error')
drawnow
% -------------------------------------------
% use parallel code that is built into kmeans
% ------------------------------
sts=statset('MaxIter',1000,'UseParallel',true);
err=nan(nLoopExec,1);
tic
for g=1:nLoopExec
  cluData=d;
  cluData(1:clu(1).n,2)=cluData(1:clu(1).n,2)+cluster1_yCenter(g)-clu(1).mn(2);
  idx=kmeans(cluData,nClu,'Replicates',nReplic,'Options',sts);
  idxArr(:,g)=idx;
end
t3=toc;

err=cluEval(idxArr,d,clu);
subplot(nClu,1,3)
plot(cluster1_yCenter,err);
grid on
xlabel('y position cluster 1')
ylabel('error')
drawnow

% show me the data:
disp(['serial: ' num2str(t1)])
disp(['parfor: ' num2str(t2)])
disp(['kmeans internal parallel: ' num2str(t3)])


% --------- local function ---------------
function err=cluEval(idx,d,clu)
nClu=numel(clu);
nLoopExec=size(idx,2);
err=nan(nLoopExec,nClu);
cumN=cumsum([0 clu.n]);
bin=1:nClu+1;
for g=1:nLoopExec
  for cI=1:nClu
    % index into cluster's data points
    ix=cumN(cI)+1:cumN(cI+1);
    % divide number of points in most frequent bin
    % by total
    err(g,cI)=1-max(histcounts(idx(ix,g),bin))/clu(cI).n;
  end
end