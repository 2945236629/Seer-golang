package com.robot.app.mapProcess
{
   import com.robot.app.sptGalaxy.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import flash.display.*;
   import flash.errors.IllegalOperationError;
   import flash.events.*;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_666 extends BaseMapProcess
   {
      
      private var _fun:Array;
      
      private var _stoneName:Array = ["玄武","青龙","白虎","朱雀"];
      
      private var _doorName:Array = ["玄武传送阵","青龙传送阵","白虎传送阵","朱雀传送阵"];
      
      public function MapProcess_666()
      {
         this._fun = [this.enterXuanwu,this.enterQinglong,this.enterBaihu,this.enterZhuque];
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         SocketConnection.send(1022,86052288);
         i = 0;
         while(i < 4)
         {
            conLevel["stone_" + i].visible = false;
            conLevel["sptDoor_" + i].visible = false;
            i++;
         }
         conLevel["task816tig"].visible = false;
         conLevel["task_811_1"].visible = false;
         conLevel["bloodMc"].visible = false;
         if(TasksManager.getTaskStatus(816) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(816,function(param1:Array):void
            {
               if(param1[0] && !param1[1] || param1[0] && param1[1] && !param1[2] || param1[0] && param1[1] && param1[2] && !param1[3] || param1[0] && param1[1] && param1[2] && param1[3] && !param1[4])
               {
                  return;
               }
               initStone();
            });
         }
         else
         {
            this.initStone();
         }
      }
      
      private function onExchangeEquipmentClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("UltraEvolutionCurseExchangePanel"),"正在加载...");
      }
      
      private function onEvolutionEquipmentClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("UltraEvolutionCurseEvolutionPanel"),"正在加载...");
      }
      
      private function initStone() : void
      {
         DisplayUtil.removeForParent(conLevel["ani_0"]);
         DisplayUtil.removeForParent(conLevel["ani_1"]);
         DisplayUtil.removeForParent(conLevel["ani_2"]);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            ToolTipManager.add(conLevel["stone_" + _loc1_],this._stoneName[_loc1_]);
            conLevel["stone_" + _loc1_].visible = true;
            conLevel["stone_" + _loc1_].buttonMode = true;
            conLevel["stone_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onStoneClick);
            ToolTipManager.add(conLevel["sptDoor_" + _loc1_],this._doorName[_loc1_]);
            conLevel["sptDoor_" + _loc1_].buttonMode = true;
            conLevel["sptDoor_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onDoorClick);
            _loc1_++;
         }
      }
      
      private function onStoneClick(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var s:String = null;
         var e:MouseEvent = param1;
         var i:int = 0;
         while(i < 4)
         {
            conLevel["sptDoor_" + i].visible = false;
            i++;
         }
         mc = e.currentTarget as MovieClip;
         s = mc.name.split("_")[1];
         conLevel["sptDoor_" + s].visible = true;
         AnimateManager.playMcAnimate(conLevel["sptDoor_" + s],0,"",function():void
         {
         });
      }
      
      private function onDoorClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Function = this._fun[uint(_loc2_.name.split("_")[1])];
         _loc3_();
      }
      
      private function enterXuanwu() : void
      {
         XuanWuController.check(this.checkTime());
      }
      
      private function enterQinglong() : void
      {
         QingLongController.check(this.checkTime());
      }
      
      private function enterBaihu() : void
      {
         BaiHuController.check(this.checkTime());
      }
      
      private function enterZhuque() : void
      {
         ZhuQueController.check(this.checkTime());
      }
      
      private function checkTime() : Boolean
      {
         if(SystemTimerManager.sysDate.getUTCHours() + 8 >= 12 && SystemTimerManager.sysDate.getUTCHours() + 8 <= 13)
         {
            return true;
         }
         return false;
      }
      
      private function startIntro() : void
      {
         throw new IllegalOperationError("由于超时未反编译");
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            ToolTipManager.remove(conLevel["stone_" + _loc1_]);
            conLevel["stone_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onStoneClick);
            ToolTipManager.remove(conLevel["sptDoor_" + _loc1_]);
            conLevel["sptDoor_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onDoorClick);
            _loc1_++;
         }
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

