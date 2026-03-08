package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.LightAngelActivity;
   import com.robot.app.task.taskscollection.Task1139;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_748 extends BaseMapProcess
   {
      
      public function MapProcess_748()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053225);
         SocketConnection.send(1022,86055723);
         btnLevel.mouseChildren = false;
         btnLevel.mouseEnabled = false;
         conLevel["fourDiamond"].visible = false;
         if(TasksManager.getTaskStatus(1139) == TasksManager.UN_ACCEPT)
         {
            conLevel["door_1"].gotoAndStop(1);
            conLevel["door_2"].gotoAndStop(1);
            conLevel["door_3"].gotoAndStop(1);
            conLevel["door_4"].gotoAndStop(1);
         }
         else if(TasksManager.getTaskStatus(1139) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(1139,function(param1:Array):void
            {
               if(!param1[2])
               {
                  conLevel["door_1"].gotoAndStop(1);
                  conLevel["door_2"].gotoAndStop(1);
                  conLevel["door_3"].gotoAndStop(1);
                  conLevel["door_4"].gotoAndStop(1);
               }
               else
               {
                  conLevel["door_1"].gotoAndStop(2);
                  conLevel["door_2"].gotoAndStop(2);
                  conLevel["door_3"].gotoAndStop(2);
                  conLevel["door_4"].gotoAndStop(2);
               }
            });
         }
         else
         {
            conLevel["door_1"].gotoAndStop(2);
            conLevel["door_2"].gotoAndStop(2);
            conLevel["door_3"].gotoAndStop(2);
            conLevel["door_4"].gotoAndStop(2);
         }
         ToolTipManager.add(conLevel["stone"],"天空之门石碑");
         ToolTipManager.add(topLevel["introBtn"],"告示牌");
         topLevel["introBtn"].addEventListener(MouseEvent.CLICK,this.onShowIntro);
         conLevel["fakeStone"].visible = false;
         conLevel["fakeStone"].mouseEnabled = false;
         conLevel["fakeStone"].mouseChildren = false;
         conLevel["fakeStone"].visible = false;
         conLevel["stone"].buttonMode = true;
         conLevel["stone"].addEventListener(MouseEvent.CLICK,this.stoneClickHandler);
         Task1139.initTaskFor748(this);
         if(this.isInActive)
         {
            Task1139.destroy();
         }
         LightAngelActivity.init(this);
      }
      
      private function onShowIntro(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("LightAngelPanel"),"正在加载...");
      }
      
      private function get isInActive() : Boolean
      {
         var _loc1_:Date = SystemTimerManager.sysDate;
         if((_loc1_.monthUTC == 6 && _loc1_.dateUTC >= 20 || _loc1_.monthUTC == 7 && _loc1_.dateUTC <= 2) && _loc1_.hoursUTC >= 4 && _loc1_.hoursUTC <= 5)
         {
            return true;
         }
         return false;
      }
      
      private function stoneClickHandler(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("SkyDoorInfoPanel"),"正在打开面板...",false);
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["stone"]);
         ToolTipManager.remove(topLevel["introBtn"]);
         conLevel["stone"].removeEventListener(MouseEvent.CLICK,this.stoneClickHandler);
         Task1139.destroy();
      }
   }
}

