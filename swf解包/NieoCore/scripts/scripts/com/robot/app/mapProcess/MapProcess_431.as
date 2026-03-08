package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.core.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_431 extends BaseMapProcess
   {
      
      public static var isChgFtMap:Boolean = false;
      
      private var _joinBtn:MovieClip;
      
      private var _teammateID:uint;
      
      private var _joinPanel:MovieClip;
      
      private var _waitMembJoinPanle:MovieClip;
      
      public function MapProcess_431()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initGhazi();
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(this._joinBtn);
         this._joinBtn.removeEventListener(MouseEvent.CLICK,this.onJoin);
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_JOIN,this.onJoinGhazi);
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_JOIN_SUC,this.onJoinFtMap);
         if(Boolean(this._joinPanel))
         {
            this._joinPanel["joinBtn"].removeEventListener(MouseEvent.CLICK,this.onJoinFight);
            this._joinPanel["stage_mc"].removeEventListener(MouseEvent.CLICK,this.onStageClick);
            this._joinPanel["choiceBtn"].removeEventListener(MouseEvent.CLICK,this.onChoiceStage);
         }
         if(Boolean(this._waitMembJoinPanle))
         {
            this._waitMembJoinPanle["closeBtn"].removeEventListener(MouseEvent.CLICK,this.onClosePanel);
         }
      }
      
      private function initGhazi() : void
      {
         isChgFtMap = false;
         GroupGhaziTowerCtrl.getInstance().setup();
         this._joinBtn = conLevel["joinBtn"];
         this._joinBtn.buttonMode = true;
         this._joinBtn.addEventListener(MouseEvent.CLICK,this.onJoin);
         ToolTipManager.add(this._joinBtn,"勇士试炼");
         if(this._waitMembJoinPanle == null)
         {
            this._waitMembJoinPanle = MapManager.currentMap.libManager.getMovieClip("WaitMembJoinPanle");
         }
         SocketConnection.addCmdListener(CommandID.GP_GHAZI_JOIN_SUC,this.onJoinFtMap);
      }
      
      private function onJoin(param1:MouseEvent) : void
      {
         var t:uint = 0;
         t = 0;
         var evt:MouseEvent = param1;
         this._joinBtn.mouseEnabled = false;
         if(this._joinPanel == null)
         {
            this._joinPanel = MapManager.currentMap.libManager.getMovieClip("JoinPanel");
         }
         LevelManager.appLevel.addChild(this._joinPanel);
         DisplayUtil.align(this._joinPanel,null,AlignType.MIDDLE_CENTER);
         this._joinPanel["stage_mc"].visible = false;
         this._joinPanel["stage_mc"].addEventListener(MouseEvent.CLICK,this.onStageClick);
         this._joinPanel["choiceBtn"].visible = false;
         this._joinPanel["choiceBtn"].addEventListener(MouseEvent.CLICK,this.onChoiceStage);
         this._joinPanel["joinBtn"].visible = false;
         this._joinPanel["joinBtn"].addEventListener(MouseEvent.CLICK,this.onJoinFight);
         this._joinPanel["closeBtn"].addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            DisplayUtil.removeForParent(_joinPanel);
         });
         t = uint(setTimeout(function():void
         {
            clearTimeout(t);
            _joinBtn.mouseEnabled = true;
         },2000));
         SocketConnection.addCmdListener(CommandID.GP_GHAZI_MAX_LEVEL,this.onGetMaxLevel);
         SocketConnection.send(CommandID.GP_GHAZI_MAX_LEVEL);
      }
      
      private function onGetMaxLevel(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_MAX_LEVEL,this.onGetMaxLevel);
         this._joinPanel["joinBtn"].visible = true;
         var _loc2_:ByteArray = param1.data as ByteArray;
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         if(_loc3_ >= 50)
         {
            this._joinPanel["choiceBtn"].visible = true;
         }
      }
      
      private function onJoinFight(param1:MouseEvent) : void
      {
         this.jion(0);
      }
      
      private function onChoiceStage(param1:MouseEvent) : void
      {
         this._joinPanel["stage_mc"].visible = !this._joinPanel["stage_mc"].visible;
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = param1.target as SimpleButton;
         if(Boolean(_loc2_))
         {
            if(_loc2_.name == "stage1_btn")
            {
               this.jion(0);
            }
            if(_loc2_.name == "stage51_btn")
            {
               this.jion(1);
            }
         }
      }
      
      private function jion(param1:int) : void
      {
         SocketConnection.addCmdListener(CommandID.GP_GHAZI_JOIN,this.onJoinGhazi);
         SocketConnection.send(CommandID.GP_GHAZI_JOIN,param1);
      }
      
      private function onJoinGhazi(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_JOIN,this.onJoinGhazi);
         DisplayUtil.removeForParent(this._joinPanel);
         LevelManager.topLevel.addChild(this._waitMembJoinPanle);
         DisplayUtil.align(this._waitMembJoinPanle,null,AlignType.MIDDLE_CENTER);
         this._waitMembJoinPanle["closeBtn"].addEventListener(MouseEvent.CLICK,this.onClosePanel);
      }
      
      private function onJoinFtMap(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_JOIN_SUC,this.onJoinFtMap);
         DisplayUtil.removeForParent(this._waitMembJoinPanle);
         this._waitMembJoinPanle = null;
         isChgFtMap = true;
         MapManager.changeLocalMap(10034,true);
      }
      
      private function onClosePanel(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._waitMembJoinPanle);
         SocketConnection.send(CommandID.GP_GHAZI_JOIN_CAL);
      }
   }
}

