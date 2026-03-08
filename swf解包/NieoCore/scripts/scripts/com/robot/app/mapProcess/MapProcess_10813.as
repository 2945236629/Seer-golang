package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10813 extends BaseMapProcess
   {
      
      private var npc:MovieClip;
      
      public function MapProcess_10813()
      {
         super();
      }
      
      override protected function init() : void
      {
         var date1:Date = null;
         var date:Date = SystemTimerManager.sysBJDate;
         if(MainManager.isDebug)
         {
            date1 = new Date(2014,1,17);
         }
         else
         {
            date1 = new Date(2015,1,17);
         }
         if(date.time >= date1.time)
         {
            if(!BitBuffSetClass.getState(22657))
            {
               BitBuffSetClass.setState(22657,1);
               ResourceManager.getResource(ClientConfig.getMapAnimate("petUnionTortoise"),function(param1:MovieClip):void
               {
                  var mc:MovieClip = param1;
                  npc = mc;
                  conLevel.addChild(mc);
                  KTool.hideMapAllPlayerAndMonster();
                  LevelManager.iconLevel.visible = false;
                  getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
                  AnimateManager.playMcAnimate(mc,0,"",function():void
                  {
                     initNpc();
                     LevelManager.iconLevel.visible = true;
                     getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
                     KTool.showMapAllPlayerAndMonster();
                  });
               });
            }
            else
            {
               ResourceManager.getResource(ClientConfig.getMapAnimate("petUnionTortoise"),function(param1:MovieClip):void
               {
                  npc = param1;
                  conLevel.addChild(param1);
                  initNpc();
               });
            }
         }
      }
      
      private function initNpc() : void
      {
         this.npc.gotoAndStop(this.npc.totalFrames);
         MapListenerManager.add(this.npc,function():void
         {
            ModuleManager.showAppModule("PetUnionTortoisePanel");
         });
      }
      
      override public function destroy() : void
      {
      }
   }
}

