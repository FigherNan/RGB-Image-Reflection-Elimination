% �����㷨ʱ��
tic
% ��ȡ10���ļ�
for image_number=1:10
    imageName=strcat(num2str(image_number),'.jpg');
    Original_image_square = imread(imageName);
    Original_image_real = imread(imageName);
    % squareΪ������ԭͼ

    [height_1 width_1 color_n] = size(Original_image_square);

    % ��������������άFFT
    if height_1>width_1
        Original_image_square(:,width_1+1:height_1,:)=0;
    elseif height_1<width_1
        Original_image_square(height_1+1:width_1,:)=0;
    else
        ;
    end


    figure;
    imshow(Original_image_real);
    title(['��',num2str(image_number),'������RGBԭͼ']);
    impixelinfo;
    % תΪ�Ҷ�ͼ
    Gray_image = rgb2gray(Original_image_square);

    Gray_image = double(Gray_image);
    [height width] = size(Gray_image);

    % dΪ��ֹƵ��
    % height,width�ֱ�Ϊ����ͼ��ĸ߶ȺͿ��
    % nΪ������˹�˲����Ľ���
    cut_off = 52;  %52
    n = 2;
    Illumination = Butterworth_Low_Pass(Gray_image,cut_off,height,width,n);

    % ���նȵĶ�̬��Χ�ȱ�����ת��Ϊ0-255
    max = max( max(Illumination));
    min = min( min(Illumination));
    for i = 1:height
        for j = 1:width
            Illumination(i,j) =  255*(Illumination(i,j)-min)/(max-min);
        end
    end
    Illumination = uint8(Illumination);
    Illumination_real(1:height_1,1:width_1) = Illumination(1:height_1,1:width_1); 

    % �����ȥ������
    Eliminate_reflection = uint8 (double(Gray_image)-double(Illumination));
    Eliminate_reflection_real(1:height_1,1:width_1) = Eliminate_reflection(1:height_1,1:width_1); 

    % �����ն����ɶ�ֵ����mask
    mask = uint8(Illumination_real);
    treshhold = 0.45;
    mask = im2bw(mask,treshhold);   %��ֵ��


    % ��䱳������ɫ
    for i = 1:height_1
        for j = 1:width_1
            m = randi(10);
            n = randi(50);
            % �ڱ���ͼ�����ȡ��
            Eliminate_reflection_RGB(i,j,:) = Original_image_real(19+m,505+n,:);
        end
    end

    for i = 1:3
        Eliminate_reflection_RGB(:,:,i) = Eliminate_reflection_RGB(:,:,i).*uint8(mask);
    end


    [K mask_inter] = Extract(Original_image_real,Original_image_real);
    for i = 1:3
        Eliminate_reflection_RGB_1(:,:,i) = Eliminate_reflection_RGB(:,:,i).*uint8(1-mask_inter);
    end

    % ��乤������ɫ
    for i = 1:height_1
        for j = 1:width_1
            m = randi(50);
            n = randi(30);
            % �ڹ���ͼ�����ȡ��
            Eliminate_reflection_RGB(i,j,:) = Original_image_real(289+m,688+n,:);
        end
    end


    for i = 1:3
        Eliminate_reflection_RGB_2(:,:,i) = Eliminate_reflection_RGB(:,:,i).*uint8(mask_inter).*uint8(mask)+18;
    end

    Eliminate_reflection_RGB = Eliminate_reflection_RGB_1+Eliminate_reflection_RGB_2;
    for i = 1:3
        Output_image_1(:,:,i)= double(Original_image_real(:,:,i)).*double(1-mask);
    end
    Output_image_1 = uint8(Output_image_1);

    Output_image = Output_image_1.*0.8+Eliminate_reflection_RGB;
    figure;
    imshow(Output_image);
     title(['��',num2str(image_number),'������ȥ�����ͼ��']);
    impixelinfo;

    K = Extract(Original_image_real,Output_image);
    figure;
    imshow(K);
    title(['��',num2str(image_number),'��������ȡ��ͼ��']);
    clc;
    clear ;
end
toc

