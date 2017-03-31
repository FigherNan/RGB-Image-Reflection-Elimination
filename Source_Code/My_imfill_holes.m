%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_imdilate���Լ�ʵ�ֵ�����㷨    %
%      ���룺��ά����image             %
%      ��������׶���ľ��󣬴�С���� % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_imfill_holes(image)

    
    % �����ܼ�һȦ�����أ��Ա㴦��
    mask = padarray(image, ones(1,2), -Inf, 'both');
    
    % ��
    mask = 1-(mask); 
    marker = mask;
    
    % ��ȡ��ȥ������һȦ������
    iner_index = cell(1,2);
    for k = 1:2
        iner_index{k} = 2:(size(marker,k) - 1);
    end
    % ����maker��������Χ��ȫ0
    marker(iner_index{:}) = -Inf;

    % ��̬ѧ�ع�
    I2 = imreconstruct(marker, mask);
    
    % ȡ��
    I2 = imcomplement(I2);
    I2 = I2(iner_index{:});

    if islogical(image)
        I2 = logical(I2);
    end
    output = I2;
 end