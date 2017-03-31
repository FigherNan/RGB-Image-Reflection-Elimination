function Output_image = Butterworth_Low_Pass(Input_image,cut_off,height,width,n)
    % ������˼��ͨ�˲��� 
    temp_mask = zeros(height,width);
    for i = 1:height
        for j=1:width
            % ���ݾ������ĵľ�����
            temp_mask(i,j) = (((i-height/2).^2+(j-width/2).^2)).^(.5);
            mask(i,j) = 1/(1+((cut_off/temp_mask(i,j))^(2*n)));
        end
    end
    % ���ò�����Ƶ�͵�Ƶֵ
    alphaL = 0.0999;
    alphaH = 1.01;

    % ʹ�ù�ʽ
    mask = ((alphaH-alphaL).*mask)+alphaL;

    % ת��Ϊ��ͨ�˲���
    mask = 1-mask;

    % ��ͼ��Iȡ����
    Input_log = log2(1+Input_image);

    % �Զ���ͼ��������Ҷ�任
    Input_fft = My_FFT2(Input_log);   

    % �Է�ֵ�������任��ѹ����̬��Χ,�Զ�ӳ�䵽�Ҷȿռ�
    temp = log(1+abs(Input_fft));     

    % �Ը���Ҷ�任���ͼ����е�ͨ������˹�˲�
    % ��ͨ�˲�֮��ȡ���˱仯Ƶ��С�Ĳ���
    % ������I(u,v)
    illumination_fft= mask.*Input_fft;

    % �Է�ֵ�������任��ѹ����̬��Χ,�Զ�ӳ�䵽�Ҷȿռ�
    temp = log(1+abs(illumination_fft));      


    % ����Ҷ��任
    illumination = My_IFFT2(illumination_fft);
    % ȡʵ��
    illumination = real(illumination);
   
    % ȡָ��
    Output_image = exp(illumination);
end 
