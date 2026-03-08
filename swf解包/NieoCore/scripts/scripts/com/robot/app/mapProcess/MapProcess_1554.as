package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.SoundManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialog;
   
   public class MapProcess_1554 extends BaseMapProcess
   {
      
      private var light:Boolean = true;
      
      private var _step:int;
      
      public function MapProcess_1554()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         SystemTimerManager.addTickFun(this.timerHandle);
         this.timerHandle();
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([124068],function(param1:Array):void
         {
            var va:Array = param1;
            _step = KTool.subByte(va[0],0,8);
            if(_step >= 11)
            {
               if(BitBuffSetClass.getState(24184) == 0)
               {
                  NpcDialog.show(5545,["终于来到这颗神秘的星球啦！咦？为什么这里如此空旷？"],["…"],[function():void
                  {
                     NpcDialog.show(5675,["一个泳馆……装潢和布局都流露着高等文明的存在，看起来也并非失落已久……难道是躲起来了？"],["…"],[function():void
                     {
                        NpcDialog.show(5675,["等等！这里的磁场！……似乎有另一个世界叠加在这颗星球……实在是太有趣了，我要好好研究一下！"],["…"],[function():void
                        {
                           BitBuffSetClass.setState(24184,1);
                        }],false,null,true);
                     }],false,null,true);
                  }],false,null,true);
               }
            }
         });
      }
      
      private function timerHandle() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Date = SystemTimerManager.sysBJDate;
         if(_loc1_.hours >= 6 && _loc1_.hours < 18)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         MapManager.currentMap.root["bg2"].visible = !_loc2_;
         MapManager.currentMap.root["bg2"].mouseEnabled = MapManager.currentMap.root["bg2"].mouseChildren = false;
         if(_loc2_ != this.light)
         {
            this.light = _loc2_;
            if(_loc2_)
            {
               SoundManager.playSoundById("BGM_676");
            }
            else
            {
               SoundManager.playSoundById("BGM_677");
            }
         }
      }
      
      override public function destroy() : void
      {
         SystemTimerManager.removeTickFun(this.timerHandle);
         super.destroy();
      }
   }
}

