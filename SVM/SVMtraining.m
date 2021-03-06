function model = SVMTraining(images, labels)
    verbose = 0;

    %binary classification
    model.type='binary';
    
    %SVM software requires labels -1 or 1 for the binary problem
    labels(labels==0)=-1;

    %Initilaise and setup SVM parameters
    lambda = 1e-20;  
    C = Inf;
    kerneloption=4;
    kernel='poly';
    
    %kerneloption= 5;
    %kernel='gaussian';
    %model.param.kerneloption=kerneloption;

    % Calculate the support vectors
    [xsup,w,w0,pos,tps,alpha] = svmclass(images,labels,C,lambda,kernel,kerneloption,verbose); 

    % create a structure encapsulating all teh variables composing the model
    model.xsup = xsup;
    model.w = w;
    model.w0 = w0;

    model.param.kerneloption=kerneloption;
    model.param.kernel=kernel;
end