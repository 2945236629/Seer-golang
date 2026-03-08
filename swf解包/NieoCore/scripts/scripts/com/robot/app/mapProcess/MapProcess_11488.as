package com.robot.app.mapProcess
{
   import com.robot.app.control.MonsterKingMonthGift0324Controller;
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11488 extends BaseMapProcess
   {
      
      private var _dialogArr:Array = new Array();
      
      public function MapProcess_11488()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int;
         KTool.hideMapAllPlayerAndMonster();
         LevelManager.iconLevel.visible = false;
         i = 0;
         while(i < 5)
         {
            (conLevel["item_" + i] as MovieClip).buttonMode = true;
            MapListenerManager.add(conLevel["item_" + i],this.onClick);
            i++;
         }
         this.update();
         MonsterKingMonthGift0324Controller.setup(function():void
         {
            var _loc2_:Array = null;
            var _loc3_:TaskMod = null;
            var _loc1_:Object = new Object();
            var _loc4_:Array = MonsterKingMonthGift0324Controller.getDialogById(9);
            _loc2_ = new Array();
            var _loc5_:int = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc1_ = _loc4_[_loc5_];
               _loc3_ = new TaskMod(TaskDiaLogManager.DIALOG,int(_loc1_.npc),[String(_loc1_.q)],[String(_loc1_.a)]);
               _loc2_.push(_loc3_);
               _loc5_++;
            }
            _dialogArr = _loc2_;
         });
      }
      
      private function update() : void
      {
         var count:uint = 0;
         count = 0;
         KTool.getMultiValue([102713],function(param1:Array):void
         {
            var a:Array = param1;
            var i:int = 0;
            while(i < 5)
            {
               if(KTool.getBit(a[0],i + 1) == 1)
               {
                  ++count;
                  conLevel["item_" + i].visible = false;
               }
               i++;
            }
            if(count == 5)
            {
               TaskDiaLogManager.single.playStory(_dialogArr,function():void
               {
                  SocketConnection.send(43711,[2,5]);
                  KTool.showMapAllPlayerAndMonster();
                  LevelManager.iconLevel.visible = true;
                  ModuleManager.showAppModule("MonsterKingMonthGiftReward0414Panel");
               });
            }
         });
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         var index:uint = uint(ename.split("_")[1]);
         FightManager.fightNoMapBoss("",9525 + index,false,true,function():void
         {
            MapManager.changeMap(11488);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
         KTool.showMapAllPlayerAndMonster();
         LevelManager.iconLevel.visible = true;
      }
   }
}

