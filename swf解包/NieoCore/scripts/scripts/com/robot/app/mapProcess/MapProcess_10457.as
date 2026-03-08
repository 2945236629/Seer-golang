package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.taskDialog.TaskStoryPlayer;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.utils.TextFormatUtil;
   import flash.display.MovieClip;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10457 extends BaseMapProcess
   {
      
      private var taskMc:MovieClip;
      
      public function MapProcess_10457()
      {
         super();
      }
      
      private static function onSwitchMap(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
         if(MapManager.currentMap.id == 6)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("SuyaleisiMainPanel"));
         }
         else
         {
            MapManager.changeMap(6);
         }
      }
      
      override protected function init() : void
      {
         if(!BufferRecordManager.getMyState(1071))
         {
            ResourceManager.getResource(ClientConfig.getMapAnimate("map_10457_suyaleisi"),function(param1:MovieClip):void
            {
               taskMc = param1;
               MapManager.currentMap.depthLevel.addChild(taskMc);
               playPreStory();
            });
         }
         else
         {
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
            MapManager.changeMap(6);
         }
      }
      
      private function playPreStory() : void
      {
         var story:Array;
         var storyPlayer:TaskStoryPlayer = null;
         KTool.hideMapAllPlayerAndMonster();
         story = [[TaskStoryPlayer.MAP_MOVIE,[this.taskMc,1,"mc1"]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["难道传说是真的？！雷蒙的" + TextFormatUtil.getRedTxtInStory("钢铁意志尤格萨隆") + "沉睡了上千年，这次苏醒难道预示着一场灾难即将发生！"],["费得•苏克上尉~~你还记得我吗？"]]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["是谁在叫我，我已经好久没有听到自己的全名了！这个声音好熟悉，难道是…"],["是你吗？苏亚雷斯！你是你在呼唤我？"]]],[TaskStoryPlayer.MAP_MOVIE,[this.taskMc,2,"mc2"]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["真的是你，你也苏醒了？感觉好点了吗？"],["沉睡了这么久，我想我已经恢复的差不多了？"]]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["太好了，这样你又能像之前一样强大了！ "],["苏克我的好朋友，感谢你为我所做的一切！"]]],[TaskStoryPlayer.DIALOG,[NPC.SUYALEISI,["回想起当时情景，至今让我难以忘怀，如果不是你，我想我可能已经成为海盗集团的战利品了！"],["那时的我太冒险了！"]]],[TaskStoryPlayer.FUL_MOVIE,["active_20140228_6",true]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["想起当时发生的一切，我被你的勇敢所震惊，你一个人尽然敢抵抗整个拜伦号！"],["我太冲动了！"]]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["事情过去这么久了，既然你已经全部恢复了，那就去做自己该做的事情吧！记得我和你在一起，我们一起守卫宇宙和平！"],["恩恩，不过我现在还有一件事要去做！"]]],[TaskStoryPlayer.DIALOG,[NPC.SUYALEISI,["我寻找了很久，一直没有找到适合我的伙伴，我觉得现在找到了，而且这个人就在我的眼前！"],["伙伴…眼前…！"]]],[TaskStoryPlayer
         .MAP_MOVIE,[this.taskMc,3,"mc3"]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["这是真的吗！太棒了，这样我和雷蒙他们一样也有自己的精灵了！"],["记住我的伙伴，我们永远在一起！"]]],[TaskStoryPlayer.DIALOG,[NPC.SHUKE,["恩恩，我们一定会生死与共的，为了宇宙的和平和精灵们的安危，我们会一直战斗下去！ "],["加油吧！苏亚雷斯！"]]],[TaskStoryPlayer.FUL_MOVIE,["active_20140228_6_2",true]]];
         storyPlayer = new TaskStoryPlayer();
         storyPlayer.addStory(story);
         storyPlayer.storyEndCallback = function():void
         {
            storyPlayer.destory();
            KTool.showMapAllPlayerAndMonster();
            DisplayUtil.removeForParent(taskMc);
            BufferRecordManager.setMyState(1071,true);
            SocketConnection.send(1022,86069713);
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
            MapManager.changeMap(6);
         };
         storyPlayer.start();
      }
      
      override public function destroy() : void
      {
      }
   }
}

