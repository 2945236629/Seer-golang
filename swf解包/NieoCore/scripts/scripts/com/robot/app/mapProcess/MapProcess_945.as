package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.systems.ErrorType;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_945 extends BaseMapProcess
   {
      
      private const TASK_ID:int = 1675;
      
      private var isGetAllStone:Boolean = false;
      
      public function MapProcess_945()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         MapListenerManager.add(this.btnLevel["btn1"],this.onClickBuBuSeed,"怎样获得布布种子");
         MapListenerManager.add(this.btnLevel["btn2"],this.onClickGoldBuBu,"怎样获得融合精灵");
         MapListenerManager.add(this.btnLevel["btn3"],this.onClickLySaBuBu,"怎样获得极品丽莎布布");
         MapListenerManager.add(this.btnLevel["btn4"],this.onClickOpenTrainPanel,"丽莎布布特训 点击进入");
         MapListenerManager.add(this.conLevel["btnShizhuLingShou"],this.onClickOpenTrainPanel,"");
         MapListenerManager.add(this.conLevel["btnBuBu"],this.onClickOpenTrainPanel,"丽莎布布特训 点击进入");
         SocketConnection.send(1022,86061454);
         ToolBarController.showOrHideAllUser(false);
         SocketConnection.addCmdListener(CommandID.NOTE_READY_TO_FIGHT,this.noteReadyToFight);
      }
      
      private function noteReadyToFight(param1:SocketEvent) : void
      {
         var event:SocketEvent = param1;
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(isGetAllStone)
            {
               Alarm.show("今天你已经获得很多特训石喽 明天再来吧");
            }
            isGetAllStone = false;
            EventManager.removeEventListener(ErrorType.getErr0rType(14498),onGetAllStoneErrHandler);
         });
         EventManager.addEventListener(ErrorType.getErr0rType(14498),this.onGetAllStoneErrHandler);
      }
      
      private function onGetAllStoneErrHandler(param1:RobotEvent) : void
      {
         this.isGetAllStone = true;
      }
      
      private function onClickBuBuSeed(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061455);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToGetThreeInitialPetPanel"));
      }
      
      private function onClickGoldBuBu(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061456);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToFusionPanel"));
      }
      
      private function onClickLySaBuBu(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061457);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 303)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("AssessorResultPanel"),"正在打开",_loc2_);
         }
         else
         {
            Alarm.show("请将丽莎布布设置为首发精灵！");
         }
      }
      
      private function onClickOpenTrainPanel(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061458);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 303)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LySaBuBuTrainPanel"));
         }
         else
         {
            Alarm.show("请将丽莎布布设置为首发精灵！");
         }
      }
      
      private function onClickFightWithBoss(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var petInfo:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(petInfo) && petInfo.id == 303)
         {
            SocketConnection.sendWithCallback(CommandID.FUCK_SHINEHOO_TIMES,function(param1:SocketEvent):void
            {
               var _loc2_:ByteArray = param1.data as ByteArray;
               var _loc3_:int = int(_loc2_.readUnsignedInt());
               _loc3_ = _loc3_ > 5 ? 5 : _loc3_;
               if(5 - _loc3_ > 0)
               {
                  FightManager.fightWithBoss("始祖灵兽",0);
               }
               else
               {
                  Alarm.show("每天只能特训5次哦");
               }
            },10435);
         }
         else
         {
            Alarm.show("请将丽莎布布设置为首发精灵！");
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         ToolBarController.showOrHideAllUser(true);
         SocketConnection.removeCmdListener(CommandID.NOTE_READY_TO_FIGHT,this.noteReadyToFight);
      }
   }
}

