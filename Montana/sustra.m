clc;
clear all
close all

x = [0.36 0.65 0.62 0.5 0.35 0.9 1 .99 .83 .88];
y = [0.85 .89 .55 .75 1 .35 .24 .55 .36 .43];


x = [1 4 4 5.5];
y = [1 1 2 1];

p = [x' y'];

s = 2;
reg = 0.1;

centros=3;

n = p;

alpha = .2;
bheta = .1;

    for j = 1:length(p)
        for h = 1:length(p)
            dn(h) = (((p(h,1)-n(j,1))^2)+((p(h,2)-n(j,2))^2));  
            ex(h) = exp(-dn(h)/(alpha/2).^2);
        end 
        D(j)=sum(ex);
    end

dm = max(D);

pos = find(D==max(D));

clus(1) = pos(1);
    
for i=1:centros    
 

for h = 1:length(p)
    dn(h) = (((p(h,1)-n(pos,1))^2)+((p(h,2)-n(pos,2))^2));  
    ex(h) = exp(-dn(h)/((bheta/2).^2));
end 

D2 = sum(ex);

D = D-dm.*D2;

D(pos) = -100;

dm = max(D);

pos = find(D==max(D));

clus(i+1) = pos(1);

end

clus=[clus(1) clus(end)]

% for i=1:length(p)
%         for h = 1:length(p)
%             
%             else
%             dn(h)=(((p(h,1)-n(i,1))^2)+((p(h,2)-n(j,2))^2))^(.5);  
%             Nodo(h)=exp(-alpha*dn(h)); 
%             end
%         end 
% end
% 
% 
% maxMMparo=max(max(M));
% maxMMparo2=.5; 
% numC=1; %% Segundo nodo 
% cont = 1;
% [A B] = find(M==max(max(M)));
%     
% coorx(cont) = p(A(1),1);
% coory(cont) = p(B(1),2);
% 
% cont = 2;
% 
% while maxMMparo/maxMMparo2>2 
% 
% for i = 1:length(n)
%     for j = 1:length(n)
%         for h = 1:length(p)
%             s = sum(i==coorx) + sum(j==coory);
%             if s == 2
%             else
%             dn(h)=(((p(h,1)-n(i,1))^2)+((p(h,2)-n(j,2))^2))^(.5);  
%             Nodo(h)=exp(-alpha*dn(h)); 
%             end
%         end 
%         M1(i,j)=sum(Nodo);
%     end
% end
% 
% for i = 1:length(n)
%     for j = 1:length(n)
%             s = sum(i==coorx) + sum(j==coory);
%             if s == 2
%             else
%             dn(h)=(((n(A,1)-n(i,1))^2)+((n(B,2)-n(j,2))^2))^(.5);  
%             Nodo(h)=exp(-bheta*dn(h)); 
%             end
%         Mm(i,j)=sum(Nodo);
%     end
% end
% 
% M2 = M1 - M*Mm;
% 
% M2 = max(M2,0);
% 
% M = M1;
% 
% [A B] = find(M==max(max(M)));
%     
% coorx(cont) = A(1);
% coory(cont) = B(1);
% 
% maxMMparo=max(max(M2));
% 
% cont = cont + 1;
% 
% if cont >= 15
%     break;
% end
% 
% end 
% 
hold on 
plot(p(:,1),p(:,2),'*')
axis([0 1 0 1]);
grid on
plot(p(clus,1),p(clus,2),'o')
% 
% figure
% surface(M2)