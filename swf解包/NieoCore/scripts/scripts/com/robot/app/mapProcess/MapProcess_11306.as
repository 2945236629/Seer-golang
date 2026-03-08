package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_11306 extends BaseMapProcess
   {
      
      public function MapProcess_11306()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(MapProcess_11305.IsFirstWin)
         {
            MapProcess_11305.IsFirstWin = false;
            conLevel["mv"].gotoAndStop(2);
            AnimateManager.playMcAnimate(conLevel["mv"],2,"mv",function():void
            {
               conLevel["mv"].gotoAndStop(1);
               refresh();
            });
         }
         else
         {
            this.refresh();
         }
         conLevel["mv"].addEventListener(MouseEvent.CLICK,this.onHaiDaoClick);
      }
      
      private function refresh() : void
      {
         KTool.getForeverNum(102072,function(param1:int):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < 3)
            {
               conLevel["mv"]["boss_" + _loc2_].visible = KTool.getBit(param1,_loc2_ + 2) == 0;
               _loc2_++;
            }
         });
      }
      
      private function onHaiDaoClick(param1:*) : void
      {
         var index:int = 0;
         var e:* = param1;
         if(e.target.name.indexOf("boss_") == -1)
         {
            return;
         }
         index = KTool.getIndex(e.target);
         NpcDialog.show(NPC.HAIDAO_3,["哼！我是不会怕你们的！"],["看我把你们打扁！","稍等！我准备一下！"],[function():void
         {
            FightManager.fightNoMapBossByCmd(45678,[2 + index],onFightOver);
         }]);
      }
      
      private function onFightOver() : void
      {
         KTool.getForeverNum(102072,function(param1:int):void
         {
            var value:int = param1;
            var isFightAll:Boolean = true;
            var i:int = 0;
            while(i < 3)
            {
               if(KTool.getBit(value,i + 2) == 0)
               {
                  isFightAll = false;
                  break;
               }
               i++;
            }
            if(isFightAll)
            {
               MapManager.currentMap.controlLevel["mv"].gotoAndStop(3);
               AnimateManager.playMcAnimate(MapManager.currentMap.controlLevel["mv"],3,"mv",function():void
               {
                  ModuleManager.showAppModule("WatchTaskPanel");
               });
            }
         });
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onHaiDaoClick);
         super.destroy();
      }
   }
}

