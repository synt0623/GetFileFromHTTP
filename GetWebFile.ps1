
$LOCAL_FILE_PATH = "C:\Mitos"

# ダウンロードする初期ファイルをJSONにする
#  フォルダ構造とファイルリストを格納するため。
<#
{
  "name": "root",
  "type": "folder",
  "children": [
    {
      "name": "documents",
      "type": "folder",
      "children": [
        {
          "name": "report.docx",
          "type": "file",
          "hash": "XXXXXXXXXXXXXXXXXXX"
        },
        {
          "name": "presentation.pptx",
          "type": "file",
          "hash": "XXXXXXXXXXXXXXXXXXX"
        }
      ]
    },
    {
      "name": "images",
      "type": "folder",
      "children": [
        {
          "name": "photo.jpg",
          "type": "file",
          "hash": "XXXXXXXXXXXXXXXXXXX"
        },
        {
          "name": "screenshots",
          "type": "folder",
          "children": []
        }
      ]
    },
    {
      "name": "README.md",
      "type": "file",
      "hash": "XXXXXXXXXXXXXXXXXXX"
    }
  ]
}
#>
#



#
# Fileのリストをダウンロードするクラス
#
class DW_FILELIST {  
    # 定数
    $proxy=$false
    $proxysv=""
    $webserver="http://kokyocloud11.mitani-corp.co.jp/abc/"
    $code = "a001"
    [System.Object[]]$filelist

    # ファイルリストのURLを作成する
    [string] CreateFileListURL(){
        $url = $this.webserver+$this.code+".list"
        return $url
    }

    # Webサーバからリストファイルを読み込む
    DW_FILELIST(){
        $listfilename = $this.CreateFileListURL()
        $this.filelist = Invoke-RestMethod -uri $listfilename  -Method Get | ConvertFrom-Csv 
        return 
    }

}

#
# ローカルにあるファイルのハッシュ一覧を作成する
#
class GET_LOCALFILE{
    [System.Object[]]$csv
    # CSVを読み込む(カラムの追加)
    GET_LOCALFILE([System.Object[]]$csv){
        $this.csv = $csv | select-object *, @{Name= "Old_Hash";Expression = {$null}},@{Name= "Status";Expression = {$null}}
    }    

    # ローカルファイルのリストをCSVデータに書き出す
    [void]GetLocalFileList(){
        Get-ChildItem -Recurse $script:LOCAL_FILE_PATH

    }



    # ハッシュ計算
    [void]filehash(){
        $this.csv| %{
            $filename = join-path $LOCAL_FILE_PATH  $_.FILENAME
            Write-Host $filename

        }


    }

}


# 存在しないフォルダを作成する
#フォルダツリーの情報もlistとしてダウンロードすることにする


# 新しいファイルをダウンロードする

# ローカル側のみのファイルを削除する


# 存在していたファイルについて、ハッシュ計算と比較する



# 必要なファイルをダウンロードし、置き換えする。



##### Main ###########

$g_csv= ([DW_FILELIST]::new()).filelist 


$cl2 = [GET_LOCALFILE]::new($g_csv)
$cl2.csv


