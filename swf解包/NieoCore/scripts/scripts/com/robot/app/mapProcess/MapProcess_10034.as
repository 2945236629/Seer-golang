package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.GroupGhaziTowerCtrl;
   import com.robot.core.CommandID;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.NonoManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.BasePeoleModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10034 extends BaseMapProcess
   {
      
      private var _membModel:BasePeoleModel;
      
      public function MapProcess_10034()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.toolsLevel.visible = false;
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.hideNono();
         this.addMembModel();
         GroupGhaziTowerCtrl.getInstance().setup();
         GroupGhaziTowerCtrl.getInstance().map = this;
         btnLevel["leaveBtn"].addEventListener(MouseEvent.CLICK,this.onLeaveMap);
         ToolTipManager.add(btnLevel["leaveBtn"],"英佩恩堡垒二层");
         SocketConnection.addCmdListener(CommandID.GP_GHAZI_LEAVE,this.onLeaveFtMap);
         if(MapProcess_431.isChgFtMap)
         {
            this.onAlarmClick();
         }
         else
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClick);
         }
      }
      
      override public function destroy() : void
      {
         GroupGhaziTowerCtrl.getInstance().destroy();
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
         if(!this._membModel)
         {
         }
      }
      
      private function addMembModel() : void
      {
         var _loc1_:Array = MainManager.actorInfo.groupInfo.memberList.concat();
         var _loc2_:uint = uint(_loc1_.indexOf(MainManager.actorID));
         _loc1_.splice(_loc2_,1);
         var _loc3_:uint = uint(_loc1_[0]);
         this._membModel = MainManager.actorInfo.groupInfo.membModelMap.getValue(_loc3_);
         if(this._membModel)
         {
            depthLevel.addChild(this._membModel);
            this._membModel.x = 540;
            this._membModel.y = 285;
         }
      }
      
      private function onLeaveMap(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         Alarm.show("确定要离开勇士试炼吗？",function():void
         {
            SocketConnection.send(CommandID.GP_GHAZI_LEAVE);
         });
      }
      
      private function onLeaveFtMap(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.GP_GHAZI_LEAVE,this.onLeaveFtMap);
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
         MapManager.changeMap(431);
      }
      
      private function onAlarmClick(param1:PetFightEvent = null) : void
      {
         MapProcess_431.isChgFtMap = false;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClick);
         GroupGhaziTowerCtrl.getInstance().playFtStart();
      }
   }
}

