package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10662 extends BaseMapProcess
   {
      
      private static var taskMc:MovieClip;
      
      public static var isFightLenny:Boolean = false;
      
      public function MapProcess_10662()
      {
         super();
      }
      
      public static function playEvoSucessMovie(param1:Function = null) : void
      {
         var fun:Function = param1;
         LevelManager.appLevel.addChild(taskMc);
         KTool.hideMapAllPlayerAndMonster();
         getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
         AnimateManager.playMcAnimate(taskMc,2,"mc1",function():void
         {
            DisplayUtil.removeForParent(taskMc);
            KTool.showMapAllPlayerAndMonster();
            getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
            if(fun != null)
            {
               fun();
            }
         });
      }
      
      override protected function init() : void
      {
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_10662_0"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            taskMc = mc;
            if(BitBuffSetClass.getState(22584) == 0)
            {
               LevelManager.appLevel.addChild(taskMc);
               KTool.hideMapAllPlayerAndMonster();
               getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
               AnimateManager.playMcAnimate(taskMc,1,"mc",function():void
               {
                  DisplayUtil.removeForParent(taskMc);
                  KTool.showMapAllPlayerAndMonster();
                  BitBuffSetClass.setState(22584,1);
                  getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
               });
            }
         });
      }
      
      override public function destroy() : void
      {
         taskMc = null;
      }
   }
}

