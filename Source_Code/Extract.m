function [K mask_inter] = Extract(Origin_image,eliminate_image)
    J = rgb2gray(Origin_image);
    % ��ֵ��,ֵԽС��ͼ�ڵ�Խ��
    I = My_im2bw(J,0.362);
    I = 1-I;
    I = My_imfill_holes(I);

    % �� 11*11��ȫ1��ȥ��ʴ;
    imrode_kernel = ones([19 19]);
    I = My_imerode(I,imrode_kernel);
    I = My_imfill_holes(I);


    % �� 11*11��ȫ1��ȥ����; 
    imdilate_kernel = imrode_kernel;
    I = My_imdilate(I,imrode_kernel);    %����
    mask_inter = I;

    mask = I;
    for i = 1:3
        K(:,:,i)=eliminate_image(:,:,i).*uint8(mask);
    end

end
