package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10849 extends BaseMapProcess
   {
      
      public function MapProcess_10849()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(BitBuffSetClass.getState(22684) == 0)
         {
            ResourceManager.getResource(ClientConfig.getMapAnimate("map10849mc"),function(param1:MovieClip):void
            {
               var mc:MovieClip = param1;
               KTool.hideMapAllPlayerAndMonster();
               ToolBarController.panel.hide();
               ToolBarController.showOrHideAllUser(false);
               LevelManager.iconLevel.visible = false;
               getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
               conLevel.addChild(mc);
               AnimateManager.playMcAnimate(mc,1,"mc",function():void
               {
                  AnimateManager.playMcAnimate(mc,2,"mc",function():void
                  {
                     AnimateManager.playMcAnimate(mc,3,"mc",function():void
                     {
                        conLevel.removeChild(mc);
                        BitBuffSetClass.setState(22684,1);
                        KTool.showMapAllPlayerAndMonster();
                        ToolBarController.panel.show();
                        ToolBarController.showOrHideAllUser(true);
                        LevelManager.iconLevel.visible = true;
                        getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
                     });
                  });
               });
            });
         }
      }
   }
}

