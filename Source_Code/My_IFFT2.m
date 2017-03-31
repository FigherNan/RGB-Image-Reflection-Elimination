%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     My_IFFT2���Լ�ʵ�ֵ�2άIFFT�㷨  %
%     ���룺ԭ�������ĵ�FFT            %
%     �������ά����image              % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [Output_image] = My_IFFT2(image)

    % ȡ������������
    [height_1,width_1] = size(image); 
    
    % ��2������ȡ��  ��ʹ��nextpow2(height_1)
    m = ceil(log2 (height_1));
    n = ceil(log2 (width_1));
    
    % ������λ�ôӾ�������ת�Ƶ��������
    %  1 | 2           3 | 4
    %  ������    =>    ������
    %  4 | 3           2 | 1
    % �����ͽ���Ƶ���������˾������ܣ����������任
    temp=image(1:2^(m-1),1:2^(n-1));
    image(1:2^(m-1),1:2^(n-1))=image(2^(m-1)+1:2^m,2^(n-1)+1:2^n);
    image(2^(m-1)+1:2^m,2^(n-1)+1:2^n)=temp;
    temp=image(1:2^(m-1),2^(n-1)+1:2^n);
    image(1:2^(m-1),2^(n-1)+1:2^n)=image(2^(m-1)+1:2^m,1:2^(n-1));
    image(2^(m-1)+1:2^m,1:2^(n-1))=temp;

    
    % ����ȫΪ��ľ�������Ľ��
    image_ifft = zeros(2.^m,2.^n);
    [height,width] = size(image_ifft);
    n_height = zeros(1, height);
    n_width = zeros(1, width);
    
    % ������е�����
    for i = 1:height
        string_1 = dec2bin(i-1,m);
        string_2 = string_1(end:-1:1);
        n_height(i) = bin2dec(string_2)+1;
    end
    
    for i = 1:width
        string_1 = dec2bin(i-1,n);
        string_2 = string_1(end:-1:1);
        n_width(i) = bin2dec(string_2)+1;
    end
    
    for i = 1:height
        for j = 1:width
            if(n_height(i)<=height_1&&n_width(j)<=width_1)
                image_ifft(i,j) = image(n_height(i),n_width(j));
            end
        end
    end

    % ����ÿһ�����õ���ת����W
    % �����任��ȣ�ֻ����һ������
    t=0:2^(m-1)-1;
    WM(t+1)=exp(2*pi*1i*t/2^m);
    
    t=0:2^(n-1)-1;
    WN(t+1)=exp(2*pi*1i*t/2^n);
    
    % �Ƚ���������
    % �𼶼���
    % mΪ��������������
    for p=1:m   
       G=2^(p-1); 
       % q������ת���ӵ�ϵ��
       for q=0:G-1
           Q=q*2^(m-p);
           % 2^pΪ����
           for k=q+1:2^p:2^m 
               % �ȼ���ÿ��Ԫ�ص�Wk*X(k)
               % ��Ϊ��һ���޸���image_fft(k+G,:)��ֵ
               temp=WM(Q+1)*(image_ifft(k+G,:));
               % ����X[k+N/2]���ȼ����
               image_ifft(k+G,:)=(image_ifft(k,:)-temp);
               % ����X[k]
               image_ifft(k,:)=(image_ifft(k,:)+temp);
           end
       end
    end
    
    % �ٽ���������
    % �𼶼���
    % nΪ��������������
    image_ifft = image_ifft/(2.^m);
    for p=1:n 
        G=2^(p-1); 
        % q������ת���ӵ�ϵ��
        for q=0:G-1
            Q=q*2^(n-p);
            % 2^pΪ����
            for k=q+1:2^p:2^n 
                % �ȼ���ÿ��Ԫ�ص�Wk*X(k)
                % ��Ϊ��һ���޸���image_fft(k+G,:)��ֵ
                temp=WN(Q+1)*image_ifft(:,k+G);
                % ����X[k+N/2]���ȼ����
                image_ifft(:,k+G)=(image_ifft(:,k)-temp);
                % ����X[k]
                image_ifft(:,k)=(image_ifft(:,k)+temp);
            end
       end
    end
    image_ifft = image_ifft/(2.^n);
    
    % ������
    Output_image = image_ifft ;
end

