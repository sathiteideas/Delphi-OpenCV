(* /*****************************************************************
  //                       Delphi-OpenCV Demo
  //               Copyright (C) 2013 Project Delphi-OpenCV
  // ****************************************************************
  // Contributor:
  // laentir Valetov
  // email:laex@bk.ru
  // ****************************************************************
  // You may retrieve the latest version of this file at the GitHub,
  // located at git://github.com/Laex/Delphi-OpenCV.git
  // ****************************************************************
  // The contents of this file are used with permission, subject to
  // the Mozilla Public License Version 1.1 (the "License"); you may
  // not use this file except in compliance with the License. You may
  // obtain a copy of the License at
  // http://www.mozilla.org/MPL/MPL-1_1Final.html
  //
  // Software distributed under the License is distributed on an
  // "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  // implied. See the License for the specific language governing
  // rights and limitations under the License.
  ******************************************************************* *)
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program cv_CopyMakeBorder;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  uLibName in '..\..\..\include\uLibName.pas',
  highgui_c in '..\..\..\include\highgui\highgui_c.pas',
  core_c in '..\..\..\include\core\core_c.pas',
  Core.types_c in '..\..\..\include\core\Core.types_c.pas',
  imgproc.types_c in '..\..\..\include\imgproc\imgproc.types_c.pas',
  imgproc_c in '..\..\..\include\imgproc\imgproc_c.pas',
  legacy in '..\..\..\include\legacy\legacy.pas',
  calib3d in '..\..\..\include\calib3d\calib3d.pas',
  imgproc in '..\..\..\include\imgproc\imgproc.pas',
  haar in '..\..\..\include\objdetect\haar.pas',
  objdetect in '..\..\..\include\objdetect\objdetect.pas',
  tracking in '..\..\..\include\video\tracking.pas',
  Core in '..\..\..\include\core\core.pas';

const
  filename = 'Resource\opencv_logo_with_text.png';

Var
  image: pIplImage = nil;
  dst: pIplImage = nil;
  dst2: pIplImage = nil;

begin
  try
    // �������� ��������
    image := cvLoadImage(filename, 1);
    WriteLn(Format('[i] image: %s', [filename]));
    // c����� ��������
    dst := cvCreateImage(cvSize(image^.width + 20, image^.height + 20), image^.depth, image^.nChannels);
    dst2 := cvCreateImage(cvSize(image^.width + 20, image^.height + 20), image^.depth, image^.nChannels);

    // ���� ��� ����������� ��������
    cvNamedWindow('original', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('IPL_BORDER_CONSTANT', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('IPL_BORDER_REPLICATE', CV_WINDOW_AUTOSIZE);

    // ��������� ��������
    cvCopyMakeBorder(image, dst, cvPoint(10, 10), IPL_BORDER_CONSTANT, cvScalar(250));
    cvCopyMakeBorder(image, dst2, cvPoint(10, 10), IPL_BORDER_REPLICATE, cvScalar(250));

    // ���������� ��������
    cvShowImage('original', image);
    cvShowImage('IPL_BORDER_CONSTANT', dst);
    cvShowImage('IPL_BORDER_REPLICATE', dst2);

    // ��� ������� �������
    cvWaitKey(0);

    // �c��������� ��c��c�
    cvReleaseImage(&image);
    cvReleaseImage(&dst);
    cvReleaseImage(&dst2);
    // ������� ����
    cvDestroyAllWindows();
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
