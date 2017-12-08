<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function launchMap() {
		$.ajax({
			url:"googleMap.mr",
			dataType:"html",
			success:function(data){
				$("#launchMapBody").html(data);
				$("#launchMapModal").modal();
			}
		});
	}
	
</script>

<a data-toggle="modal" href="#myModal" class="btn btn-primary" onclick="launchMap()">Launch modal</a>

<div class="modal" id="launchMapModal" aria-hidden="true" style="display: none; z-index: 1080; heigth:1000px;">
   	<div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title">googleMap</h4>
          </div>
          <div class="modal-body" id="launchMapBody">
          </div>
          <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn">Close</a>
          </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mapInfo" role="dialog">
</div>