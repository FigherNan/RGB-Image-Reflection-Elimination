%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_imdilate���Լ�ʵ�ֵĸ�ʴ�㷨    %
%      ���룺��ά����image             %
%            ��ʴ�� kernel            %
%      �������ʴ��ľ��󣬴�С����    % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [output] = My_imerode(image,kernel)
    % ����˵ĸߺͿ�
    [k_height,k_width] = size(kernel);
    % ��1�ĸ���
    sum_kernel = sum( sum(kernel) );

    % ȡ��
    x_center = floor(k_height/2);
    y_center = floor(k_width/2);

    % ��ԭͼ�����Ա���и�ʴ����
    image = padarray(image,[x_center y_center]);
    % ����ͼ�ĸߺͿ�
    [new_height,new_width] = size(image);

    % ���и�ʴ��������Χ��Сһ��center��ֹ����
    % ͬʱ��֤���output��ԭ����imageһ����С
    for i = x_center+1:new_height-x_center
        for j = y_center+1:new_width-y_center
            % ȡ�����һ����С�ľ���
            samesize_block = image(i-x_center:i+x_center,j-y_center:j+y_center); 
            % ������������˵��߼���
            logicand_result = kernel&samesize_block;
            % ���
            sum_result = sum( sum(logicand_result) );
            % ����С��sum_result��˵��ԭ�����(i,j)����������
            % ��ʴ��(i,j)
            if sum_result < sum_kernel
                output(i-x_center,j-y_center)=0;
            % ����˵��ԭ�����(i,j)��������
            % ����(i,j)
            else
                output(i-x_center,j-y_center)=1;
            end
        end
    end
end